//
//  FQToastMsg.m
//  BlockChain
//
//  Created by 冯倩 on 2017/8/21.
//  Copyright © 2017年 冯倩. All rights reserved.
//

#import "FQToastMsg.h"
#import "FQToastMsgView.h"
#import "FQToastWindow.h"

@implementation FQToastMsg
{
    FQToastMsgView  *_toastView;
    FQToastWindow   *_toastWindow;
    NSTimer         *_timer;
    CGFloat          _keyBoardY;
}

+ (void)ready
{
    [self sharedToastMsg];
}

+ (instancetype)sharedToastMsg
{
    static FQToastMsg *_SharedToastMsg = nil;
    if (!_SharedToastMsg)
    {
        _SharedToastMsg = [[FQToastMsg alloc] init];
    }
    return _SharedToastMsg;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _keyBoardY = [UIScreen mainScreen].bounds.size.height;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘
- (void)keyboardWillChange:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect frame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyBoardY = frame.origin.y;
    if (_keyBoardY > [UIScreen mainScreen].bounds.size.height)
    {
        _keyBoardY = [UIScreen mainScreen].bounds.size.height;
    }
    if (_toastView)
    {
        CGRect frame = _toastView.frame;
        frame.origin.x = ([UIScreen mainScreen].bounds.size.width - frame.size.width)/2;
        frame.origin.y = ([UIScreen mainScreen].bounds.size.height - frame.size.height)/2;
        if (frame.origin.y > _keyBoardY - frame.size.height)
        {
            frame.origin.y = _keyBoardY - frame.size.height;
        }
        if (frame.origin.y < 0)
        {
            frame.origin.y = 0;
        }
        _toastView.frame = frame;
    }
}

#pragma mark - 弹窗提示
+ (void)showMsg:(NSString *)msg
{
    [FQToastMsg showMsg:msg type:FQToastMsgTypeOfNormal time:3];
}

+ (void)showMsg:(NSString *)msg msgType:(FQToastMsgType)type time:(float)time
{
    [FQToastMsg showMsg:msg type:type time:time];
}
+ (void)showMsg:(NSString *)msg type:(FQToastMsgType)type time:(float)time
{
    if ([NSThread isMainThread])
    {
        [[FQToastMsg sharedToastMsg] showMsg:msg  type:type time:time];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [[FQToastMsg sharedToastMsg] showMsg:msg  type:type time:time];
                       });
    }
}

- (void)showMsg:(NSString *)msg type:(FQToastMsgType)type time:(float)time
{
    if (msg.length<1)
    {
        return;
    }
    if (!_toastView)
    {
        _toastView = [FQToastMsgView defaultToastMsgView];
        if (!_toastWindow)
        {
            _toastWindow = [[FQToastWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            _toastWindow.backgroundColor = [UIColor clearColor];
            _toastWindow.windowLevel = UIWindowLevelAlert + 1;
            _toastWindow.alpha = 0;
            _toastWindow.hidden = NO;
            _toastWindow.userInteractionEnabled = NO;
        }
        [_toastWindow addSubview:_toastView];
    }
    //在此之前,_toastView.frame是初始赋值(0,0,30,30)
    [_toastView setMsg:msg type:type];
    
    //经过[_toastView setMsg:msg type:type],_toastView.frame是初始赋值(0,0,367,120)
    CGRect frame = _toastView.frame;
    frame.origin.x = ([UIScreen mainScreen].bounds.size.width - frame.size.width)/2;
    frame.origin.y = ([UIScreen mainScreen].bounds.size.height - frame.size.height)/2;
    if (frame.origin.y > _keyBoardY - frame.size.height)
    {
        frame.origin.y = _keyBoardY - frame.size.height;
    }
    if (frame.origin.y < 0)
    {
        frame.origin.y = 0;
    }
    //经过下面的赋值,frame是初始赋值(4,237.5,367,120)
    _toastView.frame = frame;
    
    
    [UIView animateWithDuration:0.2 animations:^
    {
        _toastWindow.alpha = 1;
    }];
    if (_timer)
    {
        [_timer invalidate];
    }
    _timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(timeUp) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timeUp
{
    [UIView animateWithDuration:0.2 animations:^{
        _toastWindow.alpha = 0;
    } completion:^(BOOL finished) {
            _toastWindow.hidden = YES;
            _toastWindow = nil;
            _toastView = nil;
    }];
}

@end

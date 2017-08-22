//
//  FQToastMsgView.m
//  BlockChain
//
//  Created by 冯倩 on 2017/8/21.
//  Copyright © 2017年 冯倩. All rights reserved.
//

#import "FQToastMsgView.h"

@implementation FQToastMsgView
{
    UILabel         *_msgLabel;
    UIImageView     *_imageView;
    FQToastMsgType  _type;
}

+ (instancetype)defaultToastMsgView
{
    static FQToastMsgView *View = nil;
    if (!View)
    {
        View = [[FQToastMsgView alloc] initWithFrame:CGRectZero];
    }
    return View;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.layer.cornerRadius = 7;
        self.clipsToBounds = YES;
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
        _msgLabel.backgroundColor = [UIColor clearColor];
        _msgLabel.textColor = [UIColor whiteColor];
        [self addSubview:_msgLabel];
        _type = FQToastMsgTypeOfNormal;
        
    }
    return self;
}

- (void)setMsg:(NSString *)msg type:(FQToastMsgType)type
{
    _type = type;
    if (type == FQToastMsgTypeOfNormal)
    {
        //下面封装
        _msgLabel.frame = CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width - 30, 10000);
        _msgLabel.font = [UIFont systemFontOfSize:15];
        _msgLabel.numberOfLines = 5;
        _msgLabel.text = msg;
        
        if (_msgLabel.attributedText.size.width <= [UIScreen mainScreen].bounds.size.width - 30 && [msg rangeOfString:@"\n"].length == 0)
        {
            _msgLabel.numberOfLines = 1;
        }
        else
        {
            NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:msg];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:0];
            [style setLineBreakMode:NSLineBreakByTruncatingTail];
            [attText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attText.length)];
            _msgLabel.attributedText = attText;
        }
        [_msgLabel sizeToFit];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        
        CGRect bounds = _msgLabel.bounds;
        bounds.size.width += 30;
        bounds.size.height += 30;
        self.frame = bounds;
        
        if (_imageView)
        {
            [_imageView removeFromSuperview];
            _imageView = nil;
        }
    }
    else
    {
        if (!_imageView)
        {
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((105-34)*0.5, 23, 34, 34)];
            [self addSubview:_imageView];
        }
        if (type == FQToastMsgTypeOfSuccess)
        {
            _imageView.image = [UIImage imageNamed:@"toast_icon_success"];
        }
        else
        {
            _imageView.image = [UIImage imageNamed:@"toast_icon_fail"];
        }
        //单行字
        _msgLabel.frame = CGRectMake(15, 23+34+10, 105-30, 10000);
        _msgLabel.font = [UIFont systemFontOfSize:15];
        _msgLabel.numberOfLines = 1;
        _msgLabel.text = msg;
        _msgLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_msgLabel sizeToFit];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        CGRect frame = _msgLabel.frame;
        frame.size.width = 105-30;
        _msgLabel.frame = frame;
        self.frame = CGRectMake(0, 0, 105, 105);
    }
}


@end

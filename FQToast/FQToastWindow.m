//
//  FQToastWindow.m
//  BlockChain
//
//  Created by 冯倩 on 2017/8/21.
//  Copyright © 2017年 冯倩. All rights reserved.
//

#import "FQToastWindow.h"
#import "FQToastWindowViewController.h"

@implementation FQToastWindow
{
    FQToastWindowViewController *_VC;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _VC = [[FQToastWindowViewController alloc] init];
        self.rootViewController = _VC;
    }
    return self;
}

@end

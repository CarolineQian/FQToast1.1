//
//  FQToastMsgView.h
//  BlockChain
//
//  Created by 冯倩 on 2017/8/21.
//  Copyright © 2017年 冯倩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FQToastMsg.h"

@interface FQToastMsgView : UIView

+ (instancetype)defaultToastMsgView;

- (void)setMsg:(NSString *)msg type:(FQToastMsgType)type;

@end

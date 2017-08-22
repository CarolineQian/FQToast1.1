//
//  FQToastMsg.h
//  BlockChain
//
//  Created by 冯倩 on 2017/8/21.
//  Copyright © 2017年 冯倩. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    FQToastMsgTypeOfNormal,
    FQToastMsgTypeOfSuccess,
    FQToastMsgTypeOfFail,
}FQToastMsgType;


@interface FQToastMsg : NSObject

+ (void)ready;
+ (void)showMsg:(NSString *)msg;
+ (void)showMsg:(NSString *)msg msgType:(FQToastMsgType)type time:(float)time;


@end

//
//  ViewController.m
//  Demo
//
//  Created by 冯倩 on 2017/8/22.
//  Copyright © 2017年 冯倩. All rights reserved.
//

#import "ViewController.h"
#import "FQToastMsg.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [FQToastMsg showMsg:@"手机号与密码不匹配"];
    [FQToastMsg showMsg:@"发送成功" msgType:FQToastMsgTypeOfSuccess time:5];
    [FQToastMsg showMsg:@"发送失败" msgType:FQToastMsgTypeOfFail time:5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  TouchIDVerification
//
//  Created by CSX on 2017/3/17.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDVerification.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *myCreateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCreateButton.frame = CGRectMake(0, 0, 100, 100);
    [myCreateButton setBackgroundColor:[UIColor grayColor]];
    [myCreateButton setTitle:@"Choose" forState:UIControlStateNormal];
    [myCreateButton addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myCreateButton];

}

//调用指纹识别
- (void)buttonChoose:(UIButton *)sender{
    
    
    TouchIDVerification *touch = [[TouchIDVerification alloc]init];
    [touch touchIDVericationWithMessage:@"请按home键指纹支付" ForBack:^(BOOL isSuccess, BOOL supportTouchID, NSError *error) {
        NSLog(@"是否验证成功：%d，是否支持指纹识别：%d，错误返回消息：%@",isSuccess,supportTouchID,error.localizedDescription);
    } OrCanceelForPasswordInMainThread:^(BOOL isForPassword, BOOL isMainThreadOther) {
        NSLog(@"是否是主线程：%d",[NSThread isMainThread]);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

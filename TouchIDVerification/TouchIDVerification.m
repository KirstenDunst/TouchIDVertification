//
//  TouchIDVerification.m
//  TouchIDVerification
//
//  Created by CSX on 2017/3/17.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "TouchIDVerification.h"
#import <LocalAuthentication/LocalAuthentication.h>


@implementation TouchIDVerification

- (void)touchIDVericationForBack:(void(^)(BOOL isSuccess,BOOL supportTouchID ,NSError *error))block OrCanceelForPasswordInMainThread:(void(^)(BOOL isForPassword,BOOL isMainThreadOther))forPassword{
    //创建LAContext
    LAContext *context = [LAContext new];
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"输入密码？";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按home键指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                if (block) {
                    block(YES,YES,nil);
                }
            }else{
                if (block) {
                    block(NO,YES,error);
                }
                switch (error.code) {
                    case LAErrorSystemCancel:   //系统取消授权，如其他APP切入
                    {
                        break;
                    }
                    case LAErrorUserCancel:    //用户取消验证Touch ID
                    {
                        break;
                    }
                    case LAErrorAuthenticationFailed:      //授权失败
                    {
                        break;
                    }
                    case LAErrorPasscodeNotSet:          //系统未设置密码
                    {
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:      //设备Touch ID不可用，例如未打开
                    {
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:       //设备Touch ID不可用，用户未录入
                    {
                        break;
                    }
                    case LAErrorUserFallback:          //用户选择输入密码，切换主线程处理
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            if (forPassword) {
                                forPassword(YES,NO);
                            }
                        }];
                        break;
                    }
                    default:                //其他情况，切换主线程处理
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            if (forPassword) {
                                forPassword(NO,YES);
                            }
                        }];
                        break;
                    }
                }
            }
        }];
    }else{
        if (block) {
            block(NO,NO,error);
        }
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:         //指纹密码还没有登记
            {
                break;
            }
            case LAErrorPasscodeNotSet:            //密码未设置
            {
                break;
            }
            default:                               //指纹密码不可用
            {
                break;
            }
        }
    }
}




@end

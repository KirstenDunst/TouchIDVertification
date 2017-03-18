//
//  TouchIDVerification.h
//  TouchIDVerification
//
//  Created by CSX on 2017/3/17.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchIDVerification : NSObject



/*              三次机会
 @param   isSuccess   指纹识别是否成功
 @param   supportTouchID    是否支持指纹识别字段返回
 @param   error       指纹识别失败的原因
 
 ／／以下是当指纹识别支持的时候   即当supportTouchID为yes的时候以下才有效
 @param   isForPassword         是否先择了密码登录（已为主线程）
 @param   isMainThreadOther     是否是其他的情况（已为主线程）
 */


- (void)touchIDVericationForBack:(void(^)(BOOL isSuccess,BOOL supportTouchID,NSError *error))block OrCanceelForPasswordInMainThread:(void(^)(BOOL isForPassword,BOOL isMainThreadOther))forPassword;


@end

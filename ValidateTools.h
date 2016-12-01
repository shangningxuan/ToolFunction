//
//  VValidateTools.h
//  RayOfSunshine
//
//  Created by lich on 15/5/11.
//  Copyright (c) 2015年 lich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateTools : NSObject

// 判断是否为金额
+ (BOOL)validateMoney:(NSString *)money;

+(BOOL)validateAmountOfMoney:(NSString *)doubleNumber;

// 判断是否为数字
+ (BOOL)validateNumber:(NSString *)number;

// 判断是否为正数
+ (BOOL)validatePositiveNumber:(NSString *)number;

// 判断邮箱有效性
+ (BOOL)validateEmail:(NSString*)email;

// 验证手机有效性
+ (BOOL)validateMobile:(NSString *)mobileNum;

// 判断密码
+ (BOOL)validatePassword:(NSString *)password;

// 判断用户名
+ (BOOL)validateUserName:(NSString *)userName;

// 验证身份证是否合法
+ (BOOL)validate18PaperId:(NSString *) sPaperId;

// 验证固定电话
+ (BOOL)validateFixedLine:(NSString *)fixedLine;

// 验证中英文字符
+ (BOOL)validatechineseAndEngSet:(NSString *)aString;

@end

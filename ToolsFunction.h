//
//  ToolsFunction.h
//  RayOfSunshine
//
//  Created by hexingang on 15/4/21.
//  Copyright (c) 2015年 lich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ToolsFunction : NSObject

#pragma mark - 
#pragma mark - 字符串相关操作
// 判断字符串是否全为空格，如果为空则NO，否则返回YES
+ (BOOL)isStringAllEmpty:(NSString *)str;
// 判断字符串是否为空，如果为空则NO，否则返回YES
+ (BOOL)isStringNull:(NSString *)str;
// 判断是否为纯数字的字符串
+ (BOOL)isPureDigit:(NSString *)stringNumber;
// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font;
// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;
// 按照预设的类型将字符串日期转换成不同的类型字符串
// 0:MM.dd HH:mm
// 1:yyyy.MM.dd HH:mm
// 2:yyyy-MM-dd
// 3:yyyy-MM
+ (NSString *)dateFormatterString:(NSString *)dateString withFormatType:(NSInteger)type;
// 根据输入的日期转换成星期
+(NSString *)convertDateToWeekDay:(NSDate *)inputDate;

#pragma mark -
#pragma mark - 提示框相关操作
// 添加自定义提示框
+ (void)showPromptViewWithString:(NSString*)string;
// 添加自定义提示框(+delegate)
+ (void)showPromptViewWithString:(NSString*)string withDelegate:(id)delegate;

#pragma mark -
#pragma mark - 图片相关操作
// 处理UIImageView的圆角
+ (void)setUIImageViewRounded:(UIImageView *)imageView;
// 获取拍照后经过旋转的图片对象
+ (UIImage *)getPhotographRotateImage:(id)finishQBPickingMediaWithInfo;
// 动态压缩图片并返回压缩后的数据
+ (UIImage *)dynamicCompressImageAndWriteToFile:(UIImage *)imageSource;
// 根据最端边的尺寸进行等比例缩放原图
+ (UIImage *)scaleFixedSizeForImage:(UIImage *)sourceImage;
// 对图片进行居中截取处理
+ (UIImage *)interceptCenterImage:(UIImage *)image;
// 将图片剪切后转换成base64格式
+ (NSString *)convertBase64StringWithCutImage:(UIImage *)image;
// 对图片进行base64位编码
+ (NSString*)codeBase64DataWithImage:(UIImage *)image;
// 旋转拍照后的图片
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation;

#pragma mark -
#pragma mark - 计算相关操作
// 计算文件大小为带单位的字符串（B、KB、M、G）
+ (NSString *)stringFileSizeWithBytes:(unsigned long)fileSizeBytes;
// 比较所有版本号是否大（任意版本号格式：5.0/6.0.1/6.1.4/7.0/7.1/...）
+ (BOOL)compareAllVersions:(NSString *)highVersion withCompare:(NSString *)lowVersion;


// 跳转到AppStore的评论页面
+ (void)gotoAppStoreCommentWindow;
//计算返回时间与当前时间差值
+ (NSString *)compareCurrentTime:(NSString *)compareDate;
//去处字符串中的特殊符号
+(NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr;

#pragma mark -
#pragma mark - 其他处理操作
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (void)startCountDown:(UIButton *)button;

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
@end

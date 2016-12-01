//
//  ToolsFunction.m
//  RayOfSunshine
//
//  Created by hexingang on 15/4/21.
//  Copyright (c) 2015年 lich. All rights reserved.
//

#import "ToolsFunction.h"
#import "MBProgressHUD.h"

@interface ToolsFunction ()<MBProgressHUDDelegate>
@end
@implementation ToolsFunction

#pragma mark -
#pragma mark - 字符串相关操作
// 判断字符串是否全为空格，如果为空则NO，否则返回YES
+ (BOOL)isStringAllEmpty:(NSString *)str
{
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //看剩下的字符串的长度是否为零
    if ([temp length]!=0) {
        return NO;
    }
    return YES;
}
// 判断字符串是否为空，如果为空则NO，否则返回YES
+ (BOOL)isStringNull:(NSString *)str {
    if([str isKindOfClass:[NSNull class]] || str==nil || [str isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

// 判断是否为纯数字的字符串
+ (BOOL)isPureDigit:(NSString *)stringNumber
{
    int val = 0;
    NSScanner * scan = [NSScanner scannerWithString:stringNumber];
    
    BOOL bPureDigit = [scan scanInt:&val] && [scan isAtEnd];
    NSLog(@"TOOLS: isPureDigit: stringNumber = %@, return bPureDigit = %d", stringNumber, bPureDigit);
    return bPureDigit;
}

// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font
{
    if (stringText == nil || font == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([stringText respondsToSelector:@selector(sizeWithAttributes:)])
    {
        size = [stringText sizeWithAttributes: [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName]];
    }
    else
    {
        size = [stringText sizeWithFont: font];
    }
    
    return size;
}

// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    if (stringText == nil || font == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        CGRect rect = [stringText boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:[NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName]
                                               context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    else
    {
        size = [stringText sizeWithFont:font constrainedToSize:maxSize];
    }
    
    return size;
}

// 按照预设的类型将字符串日期转换成不同的类型字符串
+ (NSString *)dateFormatterString:(NSString *)dateString withFormatType:(NSInteger)type{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设定yyyy-MM-dd HH:mm:ss字符串转换格式
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    // 将字符串转换成date
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    switch (type) {
        case 0:
        {
            // 设定MM.dd HH:mm日期转换格式
            [dateFormatter setDateFormat:@"MM.dd HH:mm"];
        }
            break;
        case 1:
        {
            // 设定yyyy.MM.dd HH:mm日期转换格式
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        }
            break;
        case 2:
        {
            // 设定yyyy-MM-dd日期转换格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case 3:
        {
            // 设定yyyy-MM日期转换格式
            [dateFormatter setDateFormat:@"yyyy-MM"];
        }
            break;
        default:
            break;
    }
    
    // 将date转换成字符串
    NSString *destDateString = [dateFormatter stringFromDate:destDate];
    
    return destDateString;
    
}


+(NSString *)convertDateToWeekDay:(NSDate *)inputDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    NSString *strWeekDay = [weekdays objectAtIndex:theComponents.weekday];
    
    return strWeekDay;
}


#pragma mark -
#pragma mark - 提示框相关操作
// 添加自定义提示框(图片+文字)
+ (void)showPromptViewWithString:(NSString*)string{
    //获取当前window
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithWindow:window];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = string;
    [window addSubview:hub];
    hub.removeFromSuperViewOnHide = YES;
    [hub show:YES];
    [hub hide:YES afterDelay:1];
    
}

// 添加自定义提示框(图片+文字)
+ (void)showPromptViewWithString:(NSString*)string withDelegate:(id)delegate{
    //获取当前window
    UIWindow *window = [[[UIApplication sharedApplication]windows] objectAtIndex:0];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = string;
    HUD.delegate = delegate;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}


#pragma mark -
#pragma mark - 图片相关操作

// 自定义图片圆角
+(void)setUIImageViewRounded:(UIImageView *)imageView{
    imageView.layer.cornerRadius = imageView.frame.size.width/2.0;
    imageView.layer.masksToBounds = YES;
}

// 获取拍照后经过旋转的图片对象
+ (UIImage *)getPhotographRotateImage:(id)finishQBPickingMediaWithInfo
{
    if (finishQBPickingMediaWithInfo == nil) {
        return nil;
    }
    
    BOOL bValid = NO;
    UIImage *rotateImage = nil;
    
    if ([[finishQBPickingMediaWithInfo objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"ALAssetTypePhoto"])
    {
        bValid = YES;
    }
    else if ([[finishQBPickingMediaWithInfo objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        bValid = YES;
    }
    
    if (bValid) {
        // 获取当前摄像图片
        rotateImage = [finishQBPickingMediaWithInfo objectForKey:UIImagePickerControllerOriginalImage];
        
        // 旋转图片的方向
        switch (rotateImage.imageOrientation)
        {
            case UIImageOrientationUp:
                break;
            case UIImageOrientationDown:
            {
                rotateImage = [ToolsFunction rotateImage:rotateImage oritation: UIImageOrientationDown];
            }
                break;
            case UIImageOrientationLeft:
            {
                rotateImage = [ToolsFunction rotateImage:rotateImage oritation: UIImageOrientationLeft];
            }
                break;
            case UIImageOrientationRight:
            {
                rotateImage = [ToolsFunction rotateImage:rotateImage oritation: UIImageOrientationRight];
            }
                break;
            default:
                break;
        }
    }
    
    return rotateImage;
}

// 动态压缩图片并返回图片
+ (UIImage *)dynamicCompressImageAndWriteToFile:(UIImage *)imageSource
{
//    // 1. 根据最短边大于720则进行720等比例缩放
//    // 根据最大边的尺寸进行等比例缩放原图
//    UIImage * scaleFixedImage = [ToolsFunction scaleFixedSizeForImage:imageSource];
    
    // 2. 使用固定0.3比率降低JPEG质量来压缩图片
    float compressionQuality = 0.3;
    
    // 转换JPEG图片进行质量的压缩
    NSData * imageJPEGData = UIImageJPEGRepresentation(imageSource, compressionQuality);
    //    NSLog(@"DEBUG: -----compressRatio = %f, imageJPEGData.length = %@, scaleFixedImage.size = %@-----", compressionQuality, [ToolsFunction stringFileSizeWithBytes:(unsigned long)imageJPEGData.length], NSStringFromCGSize(scaleFixedImage.size));
    
    UIImage *image = [UIImage imageWithData: imageJPEGData];
    
    return image;    
}

// 根据最短边的尺寸进行等比例缩放原图
+ (UIImage *)scaleFixedSizeForImage:(UIImage *)sourceImage
{
    // 获取当前图片宽高
    float width = sourceImage.size.width;
    float height = sourceImage.size.height;
    float rate = 0.0;
    
    // 缩放时最短边的长度-720
    float scaleSideLength = 720;
    
    BOOL bScale = NO;
    UIImage* scaledImage = sourceImage;
    
    // 根据最短边是否大于720，如果大于等于则进行720等比例缩放
    if (height > width && width >= scaleSideLength) {
        
        rate = scaleSideLength / width;
        
        width = scaleSideLength;
        height = height * rate;
        
        bScale = YES;
    }
    else if (width > height && height >= scaleSideLength) {
        
        rate = scaleSideLength / height;
        
        height = scaleSideLength;
        width = width * rate;
        
        bScale = YES;
    }
    
    // 如果需要做等比例缩放则执行屏幕绘制
    if (bScale)
    {
        // UIGraphicsBeginImageContextWithOptions(CGSize size: 图片尺寸,
        // BOOL opaque: 是否设置为透明,
        // CGFloat scale: 图片缩放比（0.0则为当前手机屏幕缩放比-iPhone4~6为2倍，iPhone6+为3倍，1.0原始图片不变，2.0为固定两倍的缩放比）)
        
        //We prepare a bitmap with the new size
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 1.0);

        //Draws a rect for the image
        [sourceImage drawInRect:CGRectMake(0, 0, width, height)];
        
        //We set the scaled image from the context
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        scaledImage = [ToolsFunction interceptCenterImage:scaledImage];
        
        NSLog(@"DEBUG: scaleFixedSizeForImage - drawInRect(0, 0, width = %f, height = %f), scaleSideLength = %f", width, height, scaleSideLength);
    }
    
    return scaledImage;
}

// 对图片进行居中截取处理
+(UIImage *)interceptCenterImage:(UIImage *)image{
    float width;
    float height;
    float x;
    float y;

    if (image.size.width > image.size.height) {
        x = (image.size.width - image.size.height)/2;
        y = 0;
        width = image.size.height;
        height = image.size.width;
    }else{
        x = 0;
        y = (image.size.height - image.size.width)/2;
        width = image.size.width;
        height = image.size.width;
    }
    
    CGImageRef cgimage = CGImageCreateWithImageInRect([image CGImage], CGRectMake(x, y, width,height));
    return [UIImage imageWithCGImage:cgimage];
}

// 将图片剪切后转换成base64格式
+(NSString *)convertBase64StringWithCutImage:(UIImage *)image{
    // 对图片进行压缩
    // 1. 根据最端边大于128则进行128等比例缩放
    // 根据最大边的尺寸进行等比例缩放原图
    UIImage * scaleFixedImage = [ToolsFunction scaleFixedSizeForImage:image];
    
    // 2. 使用固定0.6比率降低JPEG质量来压缩图片
    NSData * imageJPEGData = UIImageJPEGRepresentation(scaleFixedImage, 0.8);
    NSLog(@"DEBUG: -----compressRatio = %f, imageJPEGData.length = %@, scaleFixedImage.size = %@-----", 0.8, [ToolsFunction stringFileSizeWithBytes:(unsigned long)imageJPEGData.length], NSStringFromCGSize(scaleFixedImage.size));

    // 3. 对图片进行编码
    NSString *base64String = [[imageJPEGData base64Encoding] stringByAppendingString:@".jpg"];
    
    return base64String;
}

// 对图片进行base64位编码
+ (NSString *)codeBase64DataWithImage:(UIImage *)image {
    NSData *imageJPEGData = UIImageJPEGRepresentation(image, 1);
    NSString *baseStr = [[imageJPEGData base64Encoding]stringByAppendingString:@".jpg"];
    return baseStr;
}

// 旋转拍照后的图片
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation
{
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = (CGFloat)bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef),
                                  CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    switch(theOritation) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width,
                                                         imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height,
                                                         imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (theOritation == UIImageOrientationRight || theOritation ==
        UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


#pragma mark -
#pragma mark - 计算相关操作
// 比较所有版本号是否大（任意版本号格式：5.0/6.0.1/6.1.4/7.0/7.1/...）
+ (BOOL)compareAllVersions:(NSString *)highVersion withCompare:(NSString *)lowVersion
{
    BOOL bHigh = NO;
    
    NSArray * arrayHighVersion = [highVersion componentsSeparatedByString:@"."];
    NSArray * arrayLowVersion = [lowVersion componentsSeparatedByString:@"."];
    
    // 比较每个字符串中从左边开始的版本号
    for (int i = 0; i < [arrayHighVersion count] || i < [arrayLowVersion count]; i++)
    {
        NSInteger nHigh = 0;
        NSInteger nLow = 0;
        
        // 获取高版本字符串的每个版本
        if (i < [arrayHighVersion count]) {
            nHigh = [[arrayHighVersion objectAtIndex:i] integerValue];
        }
        
        // 获取低版本字符串的每个版本
        if (i < [arrayLowVersion count]) {
            nLow = [[arrayLowVersion objectAtIndex:i] integerValue];
        }
        
        // 如果大则返回
        if (nHigh > nLow) {
            bHigh = YES;
            break;
        }
        else if (nLow > nHigh)
        {
            bHigh = NO;
            break;
        }
    }
    
    return bHigh;
}

// 计算文件大小为带单位的字符串（B、KB、M、G）
+ (NSString *)stringFileSizeWithBytes:(unsigned long)fileSizeBytes
{
    NSString * fileSizeString = @"0 B";
    
    //int fileSizeInt = [byteString intValue];
    if (fileSizeBytes > 0 && fileSizeBytes < 1024)
    {
        fileSizeString = [NSString stringWithFormat:@"0.1KB"];
    }
    else if (fileSizeBytes >= 1024 && fileSizeBytes < pow(1024, 2))
    {
        fileSizeString = [NSString stringWithFormat:@"%.1fKB", (fileSizeBytes / 1024.)];
    }
    else if (fileSizeBytes >= pow(1024, 2) && fileSizeBytes < pow(1024, 3))
    {
        fileSizeString = [NSString stringWithFormat:@"%.1fMB", (fileSizeBytes / pow(1024, 2))];
    }
    else if (fileSizeBytes >= pow(1024, 3))
    {
        fileSizeString = [NSString stringWithFormat:@"%.3fGB", (fileSizeBytes / pow(1024, 3))];
    }
    
    return fileSizeString;
}

// 跳转到AppStore的评论页面
+ (void)gotoAppStoreCommentWindow
{
    NSURL *rosCommentURL = [NSURL URLWithString:@""];
    
    // 跳转到AppStore的评论页面
    [[UIApplication sharedApplication] openURL:rosCommentURL];
}
+ (NSString *)compareCurrentTime:(NSString *)compareDate{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* inputDate = [inputFormatter dateFromString:compareDate];
    
    NSTimeInterval  timeInterval = [inputDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分前",temp];
//    }
//    
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }
//    
//    else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }
//    
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
//    
//    return  result;
    //根据客户要求更改为24小时之外均显示响应日期
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <7){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else{
        result = [NSString stringWithFormat:@"%@",[compareDate substringToIndex:10]];
    }
    
    return  result;
    
    return 0;
}
+(NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr
{
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *realSre4 = [realSre3 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    NSString *realSre5 = [realSre4 stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSArray *array = [realSre5 componentsSeparatedByString:@","];
    
    return [array objectAtIndex:0];
    
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

// 验证码倒计时
+ (void)startCountDown:(UIButton *)button {
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60 ;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [button setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                button.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
@end

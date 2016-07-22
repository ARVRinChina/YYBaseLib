//
//  CommonTool.m
//  xlzx
//
//  Created by 银羽网络 on 16/1/19.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "CommonTool.h"
#import "AppConfig.h"
#import <AVFoundation/AVFoundation.h>


@implementation CommonTool


#pragma mark - NSDate相关
+ (NSString *)dateStringWithDate:(NSDate *)date simplify:(BOOL)simplify{
    date = [date dateByAddingTimeInterval:-8*3600];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval timeInterval = ABS([date timeIntervalSinceDate:[NSDate date]]);
    
    if (simplify == NO) {
        formatter.dateFormat = @"yyyy.MM.dd HH:mm";
        return [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    }
    
    if (timeInterval < 60.0 && timeInterval >= 0) {
        return @"刚刚";
    }else if(timeInterval >= 60 && timeInterval < 3600)
    {
        return [NSString stringWithFormat:@"%d分钟前",(int)(timeInterval / 60.0)];
    }else if (timeInterval >= 3600 && timeInterval < 3600 * 24){
        return [NSString stringWithFormat:@"%d小时前",(int)(timeInterval / 3600.0)];
    }else if (timeInterval >= 3600 * 24 && timeInterval < 3600 * 24 * 2){
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"昨天 %@",[formatter stringFromDate:date]];
    }else if (timeInterval >= 3600 * 24 * 2 && timeInterval < 3600 * 24 *  3){
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"前天 %@",[formatter stringFromDate:date]];
    }else{
        formatter.dateFormat = @"yyyy.MM.dd HH:mm";
        return [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    }
}

+ (NSString *)dateStringWithDate:(NSDate *)date
{
    return [CommonTool dateStringWithDate:date simplify:YES];
}

/**
 *  开始时间到结束时间的时间区间显示，示例：2016.10.02 10:00~12:00
 *
 *  @param beginTime 开始时间
 *  @param endTime   结束时间
 *
 *  @return 字符串实例
 */
+ (NSString *)dateIntervalStringWithBeginTime:(NSDate *)beginTime endTime:(NSDate *)endTime{
    if ([endTime timeIntervalSinceDate:beginTime] >= 0) {
        NSString *beginTimeStr = [CommonTool dateStringWithDate:beginTime simplify:NO];
        NSString *endTimeStr = [CommonTool dateStringWithDate:endTime simplify:NO];
        return [NSString stringWithFormat:@"%@~%@",beginTimeStr,[endTimeStr substringFromIndex:11]];
    }
    return @"传入时间错误";
}

/**
 *  剩余时间计算
 *
 *  @param date 结束时间
 */
+ (NSString *)surplusTimeWithEndDate:(NSDate *)endDate{
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSInteger timeInterval = (NSInteger)[endDate timeIntervalSinceDate:localeDate];
    
    if (timeInterval <= 0 ) {
        return @"已经结束";
    }
    timeInterval = ABS(timeInterval);
    NSInteger year = timeInterval / (365 * 24 * 60 * 60);
    timeInterval -= (year * (365 * 24 * 60 * 60) );
    NSInteger day = timeInterval / (24 * 60 * 60);
    timeInterval -= (day * (24 * 60 * 60));
    NSInteger hour = timeInterval / (60 * 60);
    timeInterval -= (hour * 60 * 60);
    NSInteger minute = timeInterval / 60;
    timeInterval -= minute * 60;
    NSInteger second = timeInterval;
    
    NSMutableString *timeStr = [[NSMutableString alloc] init];
    if (year > 0) {
        [timeStr appendFormat:@"%ld年",year];
    }
    if (day > 0) {
        [timeStr appendFormat:@"%ld天",day];
    }
    if (hour > 0) {
        [timeStr appendFormat:@"%ld小时",hour];
    }
    if (minute > 0 ) {
        [timeStr appendFormat:@"%ld分",minute];
    }
    if (timeStr.length == 0) {
        if (second > 0) {
            [timeStr appendFormat:@"%ld秒",second];
        }
    }

    return timeStr;
}

/**
 *   将时间转换为字符串
 */
+ (NSString *)dateStringWithDateString:(NSString *)dateString simplify:(BOOL)simplify{
    if ([dateString isMemberOfClass:[NSNull class]] || dateString.length < 19) {
        return @"";
    }
    dateString = [dateString substringToIndex:19];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateStr = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    NSDate *sendDate = [[NSDate alloc] init];
    sendDate = [formatter dateFromString:dateStr];
    return [CommonTool dateStringWithDate:sendDate simplify:simplify];
}

// 根据日期计算年龄
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

/**
 *  根据生日计算星座
 *
 *  @param month 月份
 *  @param day   日期
 *
 *  @return 星座名称
 */
+(NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day
{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31){
        return @"错误日期格式!";
    }
    
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
}

+ (Constellation)calculateConstellationWithDate:(NSDate *)date{
    
    if (!date) {
        return ConstellationNoSelect;
    }
    
    NSArray *constellationArray = @[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"魔羯座",@"水瓶座",@"双鱼座"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour |
    NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    
    NSInteger month = (NSInteger)[comps month];
    NSInteger day = (NSInteger)[comps day];
    
    NSString *constellationStr = [self calculateConstellationWithMonth:month day:day];
    
    Constellation constellation = ConstellationAries;
    for (NSString *constellationString in constellationArray) {
        if ([constellationStr isEqualToString:constellationString]) {
            return constellation;
        }
        constellation ++;
    }
    return ConstellationNoSelect;
}

/**
 *  获得当前时区的当前时间
 */
+ (NSDate *)getCurrentZoneDate{
    NSDate *date = [NSDate date];
    
    return [CommonTool getCurrentZoneDateWithDate:date];
}

/**
 *  获得当前时区的时间
 */
+ (NSDate *)getCurrentZoneDateWithDate:(NSDate *)date{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}


#pragma mark - 跟图片相关

+ (NSString *)getImageUrlString:(NSString *)urlStr{
    if ([urlStr isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (urlStr.length >= 3 && [[urlStr substringToIndex:3] isEqualToString:@"../"]) {
        return [NSString stringWithFormat:@"%@%@", ImageBaseUrl, [urlStr substringFromIndex:3]];
    }
    return urlStr;
    
}

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

// 对图片大小进行压缩，压缩到不大于size（字节）
+ (UIImage *)imageWithImage:(UIImage *)image scaledToFileSize:(CGFloat)size{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (size < imageData.length) {
        CGFloat compressionQuality = size / imageData.length;
        NSData *newImageData = UIImageJPEGRepresentation(image, compressionQuality);
        UIImage *newImage = [UIImage imageWithData:newImageData];
        return newImage;
    }
    return image;
}

#pragma mark - 其他
/**
 *   将json格式的字典转换成OC中的字典
 */
+ (NSDictionary *)jsonDictionaryToDictionary:(id)jsonStr{
    if ([jsonStr isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dict = [jsonStr mutableCopy];
        for (NSString *key in dict.allKeys) {
            id obj = dict[key];
            if ([obj isMemberOfClass:[NSNull class]]) {
                [dict removeObjectForKey:key];
            }
        }
        return dict;
    }
    return nil;
}

/**
 *  获取视频封面，本地视频，网络视频都可以用
 *
 *  @param videoURL video的Url
 */
+ (void)thumbnailImageForVideo:(NSURL *)videoURL completion:(void(^)(UIImage *image))completion{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        gen.appliesPreferredTrackTransform = YES;
        
        CMTime time = CMTimeMakeWithSeconds(2.0, 600);
        
        NSError *error = nil;
        
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(thumbImg);
            }
        });
    });
}


@end

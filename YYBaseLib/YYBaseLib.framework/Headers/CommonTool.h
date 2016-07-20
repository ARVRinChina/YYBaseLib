//
//  CommonTool.h
//  xlzx
//
//  Created by 银羽网络 on 16/1/19.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumModel.h"

#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

@interface CommonTool : NSObject

/**
 *   将字符串形式的时间转换为需要的形式
 */
+ (NSString *)dateStringWithDateString:(NSString *)dateString simplify:(BOOL)simplify;

/**
 *  将NSDate转化为字符串，默认为简化
 *
 *  @param date 时间
 *
 *  @return 转化后的字符串
 */
+ (NSString *)dateStringWithDate:(NSDate *)date;

/**
 *  将NSDate转化为字符串
 *
 *  @param date     时间
 *  @param simplify 是否需要简化
 *
 *  @return 字符串实例
 */
+ (NSString *)dateStringWithDate:(NSDate *)date simplify:(BOOL)simplify;

/**
 *  开始时间到结束时间的时间区间显示，示例：2016.10.02 10:00~12:00
 *
 *  @param beginTime 开始时间
 *  @param endTime   结束时间
 *
 *  @return 字符串实例
 */
+ (NSString *)dateIntervalStringWithBeginTime:(NSDate *)beginTime endTime:(NSDate *)endTime;


/**
 *  获得当前时区的时间
 */
+ (NSDate *)getCurrentZoneDate;
/**
 *  获得当前时区的时间
 */
+ (NSDate *)getCurrentZoneDateWithDate:(NSDate *)date;

/**
 *  剩余时间计算
 *
 *  @param date 结束时间
 */
+ (NSString *)surplusTimeWithEndDate:(NSDate *)endDate;


/**
 *  截取图片路径
 *
 *  @param urlStr 图片路径
 */
+ (NSString *)getImageUrlString:(NSString *)urlStr;

/**
 *   将json格式的字典中的 NSNull --> @""
 */
+ (NSDictionary *)jsonDictionaryToDictionary:(id)jsonStr;


//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

// 对图片大小进行压缩，压缩到不大于size(字节)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToFileSize:(CGFloat)size;


/**
 *  根据日期计算年龄
 *
 *  @param date 日期
 */
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;

/**
 *  根据日期计算星座
 *
 *  @param date 日期
 */
+ (Constellation)calculateConstellationWithDate:(NSDate *)date;

/**
 *  获取视频封面，本地视频，网络视频都可以用
 *
 *  @param videoURL video的Url
 */
+ (void)thumbnailImageForVideo:(NSURL *)videoURL completion:(void(^)(UIImage *image))completion;

@end

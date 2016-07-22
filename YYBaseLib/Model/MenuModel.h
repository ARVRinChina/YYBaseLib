//
//  MenuModel.h
//  xlzx
//
//  Created by tony on 16/2/22.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject<NSCoding>

/**
 *  标识
 */
@property (nonatomic, assign) NSInteger id;

/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL selected;

-(instancetype)initWithId:(NSInteger)id name:(NSString*)name;
-(instancetype)initWithId:(NSInteger)id name:(NSString*)name selected:(BOOL)selected;

@end

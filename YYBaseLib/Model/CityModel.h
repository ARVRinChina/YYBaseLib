//
//  CityModel.h
//  xlzx
//
//  Created by tony on 16/2/2.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"

/**
 *  城市
 */
@interface CityModel : MenuModel

/**
 *  上级标识
 */
@property (nonatomic, assign) NSInteger parentId;

/**
 *  排序号
 */
@property (nonatomic, assign) NSInteger sequence;

@end

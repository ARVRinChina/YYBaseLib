//
//  CategoryModel.h
//  xlzx
//
//  Created by tony on 16/2/2.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"

/**
 *  用户技能
 */
@interface CategoryModel : MenuModel

/**
 *  上级标识
 */
@property (nonatomic, assign) NSInteger parentId;

@end

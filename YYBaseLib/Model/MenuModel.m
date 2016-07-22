//
//  MenuModel.m
//  xlzx
//
//  Created by tony on 16/2/22.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "MenuModel.h"
#import "YYModel.h"

@implementation MenuModel

-(instancetype)initWithId:(NSInteger)id name:(NSString*)name
{
    return [self initWithId:id name:name selected:NO];
}

-(instancetype)initWithId:(NSInteger)id name:(NSString*)name selected:(BOOL)selected
{
    if (self = [super init])
    {
        _id = id;
        _name = name;
        _selected = selected;
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

@end

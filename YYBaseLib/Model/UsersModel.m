//
//  UsersModel.m
//  xlzx
//
//  Created by tony on 16/1/12.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "UsersModel.h"
#import "YYModel.h"

@implementation UsersModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @"id",
             @"name" : @"nickName",
             @"portraitUri" : @"face"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)save {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingString:[NSString stringWithFormat:@"/%@.data", NSStringFromClass([self class])]];
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (instancetype)currentUser {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingString:[NSString stringWithFormat:@"/%@.data", NSStringFromClass([self class])]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end

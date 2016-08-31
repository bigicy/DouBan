//
//  Collection.m
//  豆瓣电影
//
//  Created by lanou on 16/6/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "Collection.h"

@implementation Collection

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}

@end

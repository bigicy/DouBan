//
//  ActivityModel.h
//  豆瓣电影
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic,strong)NSString *begin_time;

@property (nonatomic,strong)NSString *category_name;
@property (nonatomic,strong)NSString *address;
// 感兴趣
@property (nonatomic,strong)NSNumber *wisher_count;
//参加
@property (nonatomic,strong)NSNumber *participant_count;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *image;

@property (nonatomic,strong)NSDictionary *owner;
//@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *content;

@end

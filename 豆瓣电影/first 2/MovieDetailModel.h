//
//  MovieDetailModel.h
//  豆瓣电影
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailModel : NSObject

// 标题
@property (nonatomic,strong)NSString *title;
// 图片
@property (nonatomic,strong)NSString *poster;
// ID
@property (nonatomic,strong)NSString *movieid;
// 评分
@property (nonatomic,strong)NSString *rating;
// 日期
@property (nonatomic,strong)NSString *release_date;
// 制作人
@property (nonatomic,strong)NSString *actors;
// 电影情节
@property (nonatomic,strong)NSString *plot_simple;
// 剧情
@property (nonatomic,strong)NSString *genres;
// 电影位置
@property (nonatomic,strong)NSString *film_locations;
// 播放时间
@property (nonatomic,strong)NSString *runtime;



@end

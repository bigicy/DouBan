//
//  MovieDetailCell.h
//  豆瓣电影
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *gerensLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;


@property (weak, nonatomic) IBOutlet UILabel *plotSimpleLabel;
@end

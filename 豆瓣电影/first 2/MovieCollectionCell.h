//
//  MovieCollectionCell.h
//  豆瓣电影
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)MovieModel *model;
@end

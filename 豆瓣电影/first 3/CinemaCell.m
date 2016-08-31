//
//  CinemaCell.m
//  作业
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell

- (void)layoutSubviews
{
    _view.layer.cornerRadius = 10.f;
    _view.layer.borderWidth = 2.f;
    _view.layer.borderColor = [[UIColor grayColor]CGColor];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

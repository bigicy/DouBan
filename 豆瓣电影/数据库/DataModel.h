//
//  DataModel.h
//  豆瓣电影
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DataModel : NSObject

@property (nonatomic,strong) NSString *address;
//参加
@property (nonatomic)NSInteger participant;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UIImage*image;

@property (nonatomic)NSInteger myID;

@end

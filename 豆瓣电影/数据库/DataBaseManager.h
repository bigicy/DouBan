//
//  DataBaseManager.h
//  豆瓣电影
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataBaseManager : NSObject
// 创建单例
+ (instancetype)shareDateBase;
// 打开数据库
- (void)openDataBase;
// 关闭数据库
- (void)closeDataBase;
// 创建数据表
- (void)creatTableWithTableName:(NSString *)tableName;
// 添加数据
- (void)insertWithTableName:(NSString *)tableName  title:(NSString *)title address:(NSString *)address image:(UIImage *)image participant:(NSInteger)participant myID:(NSInteger)myID;
// 删除数据
- (void)deleteTableWithTableName:(NSString *)tableName myID:(NSInteger)myID;
// 更新数据
- (void)updateWithTableName:(NSString *)tableName  title:(NSString *)title address:(NSString *)address image:(UIImage *)image participant:(NSInteger)participant myID:(NSInteger)myID forMyID:(NSInteger)myID;
// 查数据
- (NSArray *)selectTableWithTableName:(NSString *)tableName;

- (NSArray *)selectTableWithTableName:(NSString *)tableName Title:(NSString *)Title;

@end

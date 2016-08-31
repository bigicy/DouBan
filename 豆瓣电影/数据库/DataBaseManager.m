
//
//  DataBaseManager.m
//  豆瓣电影
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DataBaseManager.h"
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DataModel.h"
@interface DataBaseManager ()

@property (nonatomic,strong)NSString *dataPath;
@end



@implementation DataBaseManager

- (NSString *)dataPath
{
    if (!_dataPath) {
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _dataPath = [documents stringByAppendingPathComponent:@"activity.sqlite"];
    }
    return _dataPath;
}

static DataBaseManager *_dataBase = nil;
// 创建单例
+ (instancetype)shareDateBase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_dataBase) {
            _dataBase = [[DataBaseManager alloc] init];
        }
    });
     return _dataBase;
}


// 打开数据库
static sqlite3 *db = nil;

- (void)openDataBase
{
    int result = sqlite3_open(self.dataPath.UTF8String, &db);
    if (result==SQLITE_OK) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}
// 关闭数据库
- (void)closeDataBase
{
    int result = sqlite3_close(db);
    if (result==SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
    
}
// 创建数据表
- (void)creatTableWithTableName:(NSString *)tableName
{
    [self openDataBase];
    NSString *creatSql = [NSString stringWithFormat:@"create table if not exists %@(ID integer primary key autoincrement,title text, address text, image blob, participant integer, myID integer)",tableName];
    int result = sqlite3_exec(db, creatSql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建数据表成功");
    }else{
        NSLog(@"创建数据表失败");
    }
    [self closeDataBase];
}
// 添加数据
- (void)insertWithTableName:(NSString *)tableName  title:(NSString *)title address:(NSString *)address image:(UIImage *)image participant:(NSInteger)participant myID:(NSInteger)myID
{
    [self openDataBase];
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@(title,address,image,participant,myID) values (?,?,?,?,?)",tableName];
    sqlite3_stmt *stmt = nil;
    int flag = sqlite3_prepare(db, insertSql.UTF8String, -1, &stmt, NULL);
    if (flag == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, address.UTF8String, -1, NULL);
        NSData *data = UIImagePNGRepresentation(image);
        sqlite3_bind_blob(stmt, 3, data.bytes, (int)data.length, NULL);
        sqlite3_bind_int64(stmt, 4, participant);
        sqlite3_bind_int64(stmt, 5, myID);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    [self closeDataBase];
}

// 删除数据
- (void)deleteTableWithTableName:(NSString *)tableName myID:(NSInteger)myID
{
    [self openDataBase];
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where myID = ?",tableName];
    sqlite3_stmt *stmt = nil;
    int flag = sqlite3_prepare(db, deleteSql.UTF8String, -1, &stmt, NULL);
    if (flag == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, myID);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    [self closeDataBase];
}
// 更新数据
- (void)updateWithTableName:(NSString *)tableName  title:(NSString *)title address:(NSString *)address image:(UIImage *)image participant:(NSInteger)participant myID:(NSInteger)myID forMyID:(NSInteger)forMyID
{
    [self openDataBase];
    NSString *updataSql = [NSString stringWithFormat:@"update %@ set title = ?, address = ?, image = ?, participant = ?, myID = ? where myID = ?", tableName];
    sqlite3_stmt *stmt = nil;
    int flag = sqlite3_prepare(db, updataSql.UTF8String, -1, &stmt, NULL);
    if (flag == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, address.UTF8String, -1, NULL);
        NSData *data = UIImagePNGRepresentation(image);
        sqlite3_bind_blob(stmt, 3, data.bytes, (int)data.length, NULL);
        sqlite3_bind_int64(stmt, 4, participant);
        sqlite3_bind_int64(stmt, 5, myID);
        sqlite3_bind_int64(stmt, 6, forMyID);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    [self closeDataBase];
}
// 查数据
- (NSArray *)selectTableWithTableName:(NSString *)tableName
{
    [self openDataBase];
    NSString *selectSql = [NSString stringWithFormat:@"select *from %@",tableName];
    NSMutableArray *array = [NSMutableArray array];
    sqlite3_stmt *stmt = nil;
    int flag = sqlite3_prepare(db, selectSql.UTF8String, -1, &stmt, NULL);
    if (flag == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            DataModel *model = [[DataModel alloc] init];
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *address = sqlite3_column_text(stmt, 2);
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 3) length:sqlite3_column_bytes(stmt, 3)];
            NSInteger participant = sqlite3_column_int64(stmt, 4);
            NSInteger myID = sqlite3_column_int64(stmt, 5);
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.address = [NSString stringWithUTF8String:(const char *)address];
            model.participant = participant;
            model.myID = myID;
            model.image = [UIImage imageWithData:data];
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    [self closeDataBase];
    return array;
}

- (NSArray *)selectTableWithTableName:(NSString *)tableName Title:(NSString *)Title
{
    [self openDataBase];
    NSString *selectSql = [NSString stringWithFormat:@"select *from %@ where Title = ?",tableName];
    NSMutableArray *array = [NSMutableArray array];
    sqlite3_stmt *stmt = nil;
    int flag = sqlite3_prepare(db, selectSql.UTF8String, -1, &stmt, NULL);
    if (flag == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, Title.UTF8String, -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            DataModel *model = [[DataModel alloc] init];
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            NSString *string = [NSString stringWithUTF8String:(const char *)title];
            [array addObject:string];
        }
    }
    sqlite3_finalize(stmt);
    [self closeDataBase];
    return array;
}






@end

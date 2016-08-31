//
//  MyViewController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyViewController.h"
#import "MyCell.h"
#import "LoginController.h"
#import "MyActivityController.h"
#import "MyMovieController.h"
#import "DataBaseManager.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *array;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTabview];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:(UIBarButtonItemStylePlain) target:self action:@selector(action)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)action
{
    LoginController *loginVC = [[LoginController alloc] init];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setupTabview
{
    self.array = @[@"我的活动",@"我的电影",@"清除缓存"];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = [UIColor blackColor];
    [tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.label.text = _array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        MyActivityController *ActiVC = [[MyActivityController alloc] init];
        [self.navigationController pushViewController:ActiVC animated:YES];
    }if (indexPath.row==1) {
        MyMovieController *movieVC = [[MyMovieController alloc] init];
        [self.navigationController pushViewController:movieVC animated:YES];
    }if (indexPath.row==2) {
        [self setupAlertWithMessage:@"确认注销"];
    }
}

- (void)setupAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[DataBaseManager shareDateBase]deleteTableWithTableName:@"Activity" myID:1];
        [[DataBaseManager shareDateBase]deleteTableWithTableName:@"Movie" myID:1];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

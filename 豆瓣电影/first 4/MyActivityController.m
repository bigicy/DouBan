//
//  MyActivityController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyActivityController.h"
#import "Collection.h"
#import "MyActivityCell.h"
#import "DataBaseManager.h"
#import "DataModel.h"
@interface MyActivityController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    [self analyseData];
    [self setupRightNavigationButton];
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyActivityCell" bundle:nil] forCellReuseIdentifier:@"MyActivityCell"];
    [self.view addSubview:_tableView];
}


- (void)analyseData
{
    self.dataArray = [[[DataBaseManager shareDateBase]selectTableWithTableName:@"Activity"]mutableCopy];
    NSLog(@"%@",self.dataArray);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyActivityCell" forIndexPath:indexPath];
    DataModel *model = _dataArray[indexPath.row];
    cell.myLabel.text = model.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)setupRightNavigationButton
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(btnClick:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}


- (void)btnClick:(UIBarButtonItem *)button
{
    if (_tableView.isEditing == NO) {
        [_tableView setEditing:YES animated:YES];
        button.title = @"完成";
    }else{
        button.title = @"编辑";
        [_tableView setEditing:NO animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [_tableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

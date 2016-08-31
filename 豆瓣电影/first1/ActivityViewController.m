//
//  ActivityViewController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import "MovieViewController.h"
#import "UIImageView+WebCache.h"

#import "DetailController.h"
#import "DataBaseManager.h"
@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ActivityViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)analyseJson
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ActivityList.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in dictionary[@"events"]) {
        ActivityModel *model = [[ActivityModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
//        [[DataBaseManager shareDateBase]insertWithTableName:@"Activity" title:model.title address:model.address image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image]]] participant:(NSInteger)model.participant_count myID:1];
        [self.dataArray addObject:model];
    }
}

- (void)analyseActivityData
{
    NSURL *url = [NSURL URLWithString:kURLDoubanActivityString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       
        for (NSDictionary *dic in dictionary[@"events"]) {
            ActivityModel *model = [[ActivityModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
//            [[DataBaseManager shareDateBase]insertWithTableName:@"Activity" title:model.title address:model.address image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image]]] participant:model.participant_count.intValue myID:1];
            [self.dataArray addObject:model];
        };
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
    [task resume];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:nil] forCellReuseIdentifier:@"ACell"];
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ACell" forIndexPath:indexPath];
    ActivityModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.begin_timeLabel.text = model.begin_time;
    cell.addressLabel.text = model.address;
    cell.category_nameLabel.text = model.category_name;
    cell.wisher_countLabel.text = [model.wisher_count stringValue];
    cell.participant_countLabel.text = [model.participant_count stringValue];
    NSURL *url = [NSURL URLWithString:model.image];
    cell.pictureImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//    [cell.pictureImage sd_setImageWithURL:url placeholderImage:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *detailVC = [[DetailController alloc]init];
    ActivityModel *model = self.dataArray[indexPath.row];
    detailVC.model = model;
//    [self transitionFromViewController:self toViewController:detailVC duration:3 options:(UIViewAnimationOptionTransitionFlipFromRight) animations:nil completion:nil];
    detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (void)setupRightNavigationBar
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(btnAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)btnAction:(UIBarButtonItem *)button
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
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
//    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[DataBaseManager shareDateBase]creatTableWithTableName:@"Activity"];
  //  [self analyseJson];
    [self analyseActivityData];
    [self setupTableView];
    [self setupRightNavigationBar];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  CinemaViewController.m
//  作业
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaCell.h"
#import "CinemaModel.h"
@interface CinemaViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CinemaViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)analyseData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cinemalist.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    for (NSDictionary *dic in dictionary[@"result"][@"data"]) {
        CinemaModel *model = [[CinemaModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
}

- (void)analyseCinemaDataFirstWay
{
    NSURL *url =[NSURL URLWithString:kURLCinemaString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *data =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in dictionary[@"result"][@"data"]) {
        CinemaModel *model = [[CinemaModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
}

- (void)analyseCinemaDataSecondWay
{
    NSURL *url = [NSURL URLWithString:kURLMovieString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dictionary[@"result"][@"data"]) {
            CinemaModel *model = [[CinemaModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"CinemaCell" bundle:nil] forCellReuseIdentifier:@"CinemaCell"];
    [self.view addSubview:tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell" forIndexPath:indexPath];
    CinemaModel *model = _dataArray[indexPath.row];
    cell.cinemaLabel.text = model.cinemaName;
    cell.addressLabel.text = model.address;
    cell.telephoneLabel.text = model.telephone;
    return cell;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analyseData];
    [self setupTableView];
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

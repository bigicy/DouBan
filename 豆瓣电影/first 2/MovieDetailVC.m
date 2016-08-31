//
//  MovieDetailVC.m
//  豆瓣电影
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MovieDetailVC.h"
#import "MovieModel.h"
#import "MovieCell.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailViewController.h"

@interface MovieDetailVC ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableData *data;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MovieDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analyseData];
    [self setupTabview];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    imageV.image = [UIImage imageNamed:@"bg_nav.png"];
    [self.view addSubview:imageV];
    UIButton *rightbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightbutton.frame = CGRectMake(self.view.bounds.size.width-40, 30, 30, 30);
    [rightbutton setImage:[UIImage imageNamed:@"btn_nav_collection@2x.png"] forState:(UIControlStateNormal)];
    [rightbutton addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightbutton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(170, 20, 50, 50)];
    label.text = @"电影";
    [self.view addSubview:label];
}

- (void)rightButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)analyseData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MovieList.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    for (NSDictionary *dic in dictionary[@"result"]) {
        MovieModel *model = [[MovieModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
}

- (void)analyseMovieData
{
    NSURL *url = [NSURL URLWithString:kURLDoubanMovieString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
    self.data = [NSMutableData data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in dictionary[@"result"]) {
        MovieModel *model = [[MovieModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

- (void)setupTabview
{
     self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    MovieModel *model = _dataArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.pic_url];
    [cell.movieImage sd_setImageWithURL:url placeholderImage:nil];
    cell.movieLabel.text = model.movieName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieModel *model = _dataArray[indexPath.row];
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc] init];
    movieDetailVC.string = model.movieId;
    movieDetailVC.labelText = model.movieName;
    [self presentViewController:movieDetailVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

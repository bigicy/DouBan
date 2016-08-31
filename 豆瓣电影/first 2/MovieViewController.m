//
//  MovieViewController.m
//  作业
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
#import "MovieCollectionCell.h"
#import "MovieDetailViewController.h"
#import "MovieDetailModel.h"
#import "MovieDetailVC.h"
@interface MovieViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NSURLSessionDataDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSMutableData *data;

@end

@implementation MovieViewController

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
    });
}



- (void)setupCollectionView
{
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"MovieCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MovieCollectionCell"];
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    MovieModel *model = _dataArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.pic_url];
    [cell.imageV sd_setImageWithURL:url placeholderImage:nil];
    cell.titleLabel.text = model.movieName;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 75/4, 10, 75/4);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieModel *model = _dataArray[indexPath.row];
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc] init];
    movieDetailVC.string = model.movieId;
    movieDetailVC.labelText = model.movieName;
    [self presentViewController:movieDetailVC animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self analyseData];
  //  [self analyseMovieData];
   // [self setupTabview];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCollectionView];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_list@2x.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(BarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}


- (void)BarButtonAction
{
    MovieDetailVC *VC = [[MovieDetailVC alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
    [self.navigationController presentViewController:VC animated:YES completion:nil];
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

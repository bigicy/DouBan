//
//  MovieDetailViewController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailCell.h"
#import "DataBaseManager.h"
@interface MovieDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self CustomView];
    [self analyseData];
    [[DataBaseManager shareDateBase]creatTableWithTableName:@"Movie"];

    // Do any additional setup after loading the view.
}


- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MovieDetailCell" bundle:nil] forCellReuseIdentifier:@"MovieDetailCell"];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 1000;
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}



- (void)CustomView
{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    imageV.image = [UIImage imageNamed:@"bg_nav.png"];
    [self.view addSubview:imageV];
    UIButton *leftbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftbutton.frame = CGRectMake(10, 10, 40, 40);
    [leftbutton setImage:[UIImage imageNamed:@"btn_nav_back@2x.png"] forState:(UIControlStateNormal)];
    [leftbutton addTarget:self action:@selector(leftButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *rightbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightbutton.frame = CGRectMake(self.view.bounds.size.width-50, 10, 40, 40);
    [rightbutton setImage:[UIImage imageNamed:@"btn_nav_share@2x.png"] forState:(UIControlStateNormal)];
    [rightbutton addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:leftbutton];
    [self.view addSubview:rightbutton];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 250, 40)];
    _label.text = _labelText;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

- (void)leftButtonAction
{
    [self  dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonAction
{
    NSString *string = [[[DataBaseManager shareDateBase]selectTableWithTableName:@"Movie" Title:_model.title]lastObject];
    if ([string isEqualToString:_model.title]) {
        [self setupAlartWithMessage:@"该活动已被收藏过"];
    }else{
    [[DataBaseManager shareDateBase]insertWithTableName:@"Movie" title:_model.title address:_model.film_locations image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.poster]]] participant:0  myID:1];
    [self setupAlartWithMessage:@"收藏成功"];
    }
}

- (void)setupAlartWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)analyseData
{
    NSString *string = [NSString stringWithFormat:@"m%@.txt",_string];
    NSString *path = [[NSBundle mainBundle]pathForResource:string ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.model = [[MovieDetailModel alloc] init];
    [_model setValuesForKeysWithDictionary:dictionary[@"result"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieDetailCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.poster]]];
    cell.plotSimpleLabel.text = _model.plot_simple;
    cell.runtimeLabel.text = _model.runtime;
    cell.actorsLabel.text = _model.actors;
    cell.locationLabel.text = _model.film_locations;
    cell.ratingLabel.text = _model.rating;
    cell.gerensLabel.text = _model.genres;
    cell.releaseDateLabel.text = _model.release_date;
    
    return cell;
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

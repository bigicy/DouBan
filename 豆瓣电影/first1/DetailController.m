//
//  DetailController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DetailController.h"
#import "ADetailCell.h"
#import "Collection.h"
#import "DataBaseManager.h"

@interface DetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableVeiw;

@end

@implementation DetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataBaseManager shareDateBase]creatTableWithTableName:@"Activity"];
    
    self.tableVeiw = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
    _tableVeiw.delegate = self;
    _tableVeiw.dataSource = self;
    [_tableVeiw registerNib:[UINib nibWithNibName:@"ActivityDetailCell" bundle:nil] forCellReuseIdentifier:@"DeCell"];
    [self.view addSubview:_tableVeiw];
    
    _tableVeiw.rowHeight = UITableViewAutomaticDimension;
    _tableVeiw.estimatedRowHeight = 1000;
    
    [self CustomView];
    
//    self.navigationController.navigationBar.translucent = NO;
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
    [self.view addSubview:_label];
    _label.text = _model.title;
    
}
- (void)leftButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonAction
{
    NSString *string = [[[DataBaseManager shareDateBase]selectTableWithTableName:@"Activity" Title:_model.title]lastObject];
    if ([string isEqualToString:_model.title]) {
        [self setupAlertMessage:@"该活动已经被收藏过"];
    }else{
        [[DataBaseManager shareDateBase]insertWithTableName:@"Activity" title:_model.title address:_model.address image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.image]]] participant:_model.participant_count.intValue myID:1];
    NSLog(@"%@",[[NSString alloc]initWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]]);
    [self setupAlertMessage:@"收藏成功"];
    }
}

- (void)setupAlertMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeCell" forIndexPath:indexPath];
    cell.addressLabel.text = _model.address;
    cell.nameLabel.text = _model.owner[@"name"];
    cell.beginLabel.text = _model.begin_time;
    cell.endLabel.text = _model.end_time;
    cell.contentLabel.text = _model.content;
    cell.categaryLabel.text = _model.category_name;
    cell.imageV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.image]]];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

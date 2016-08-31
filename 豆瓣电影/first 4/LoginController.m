//
//  LoginController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginController.h"
#import "RegistController.h"
#import "MyViewController.h"
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.password.secureTextEntry = YES;
    self.switchButton.on = NO;
}

- (IBAction)loginButton:(id)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![[user objectForKey:self.userName.text] isEqualToString:self.password.text]) {
        [self setupAlertWithMessage:@"用户名与密码不匹配"];
    }else{
        [self setupAlertWithMessage:@"登录成功"];
    }
}



- (void)setupAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if ([message isEqualToString:@"登录成功"]) {
            MyViewController *myVC = [[MyViewController alloc] init];
            myVC.navigationItem.rightBarButtonItem.title = @"注销";
//            [self.navigationController pushViewController:myVC animated:YES ];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registButton:(id)sender {
    RegistController *registVC = [[RegistController alloc] init];
    [self presentViewController:registVC animated:YES completion:nil];
}

- (IBAction)switchButton:(id)sender {
    if (self.switchButton.on == YES) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        self.password.text = [user objectForKey:self.userName.text];
    }
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

//
//  RegistController.m
//  豆瓣电影
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RegistController.h"

@interface RegistController ()<UITextFieldDelegate>

@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.firstTF.tag = 1;
    self.secondTF.tag = 2;
    self.secondTF.secureTextEntry = YES;
    self.thirdTF.tag = 3;
    self.thirdTF.secureTextEntry = YES;
    self.fourthTF.tag = 4;
    self.fourthTF.userInteractionEnabled = YES;
    self.fifthTF.tag = 5;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    if (tag!=5) {
        [[self.view viewWithTag:tag+1]becomeFirstResponder];
    }else{
        [[self.view viewWithTag:tag] resignFirstResponder];
    }
    return YES;
}


- (IBAction)registButton:(id)sender {
    NSString *userNameStr = self.firstTF.text;
    NSString *passwordStr = self.secondTF.text;
    NSString *rePasswordStr = self.thirdTF.text;
    if (userNameStr.length==0||passwordStr.length==0) {
        [self setupAllartWithMesssage:@"用户名和密码不能为空"];
    }
    else if (![passwordStr isEqualToString:rePasswordStr]) {
        [self setupAllartWithMesssage:@"两次密码不符合"];
    }else {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:passwordStr forKey:userNameStr];
        [self setupAllartWithMesssage:@"注册成功"];
    }
}

- (void)setupAllartWithMesssage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

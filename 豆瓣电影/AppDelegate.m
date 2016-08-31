//
//  AppDelegate.m
//  豆瓣电影
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import "ActivityViewController.h"
#import "MovieViewController.h"
#import "CinemaViewController.h"
#import "MyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

 - (void)setupWindow
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window .backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
}


- (void)setupTabBarItem
{
    ActivityViewController *activityVC = [[ActivityViewController alloc]init];
    activityVC.title = @"活动";
    UINavigationController *activityNC = [[UINavigationController alloc]initWithRootViewController:activityVC];
    activityNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"活动"image:[[UIImage imageNamed:@"activity"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] tag:10];
    
    [activityNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    MovieViewController *movieVC = [[MovieViewController alloc]init];
    movieVC.title = @"电影";
    UINavigationController *movieNC = [[UINavigationController alloc]initWithRootViewController:movieVC];
    movieNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"电影"image:[[UIImage imageNamed:@"movie"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] tag:20];
    [movieNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
   CinemaViewController *cinemaVC = [[CinemaViewController alloc]init];
    cinemaVC.title = @"影院";
    UINavigationController *cinemaNC = [[UINavigationController alloc]initWithRootViewController:cinemaVC];
    cinemaNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"影院"image:[[UIImage imageNamed:@"cinema"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] tag:30];
    [cinemaNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    MyViewController *myVC = [[MyViewController alloc]init];
    myVC.title = @"我的";
    UINavigationController *myNC = [[UINavigationController alloc]initWithRootViewController:myVC];
    myNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的"image:[[UIImage imageNamed:@"user"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] tag:40];
    [myNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    UITabBarController *tabBarCtrl = [[UITabBarController alloc]init];
    tabBarCtrl.viewControllers = @[activityNC,movieNC,cinemaNC,myNC];
    
    _window.rootViewController = tabBarCtrl;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupWindow];
    [self setupTabBarItem];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

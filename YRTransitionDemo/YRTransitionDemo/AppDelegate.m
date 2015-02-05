//
//  AppDelegate.m
//  YRTransitionDemo
//
//  Created by 王晓宇 on 14-6-18.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "YRTransitionKit.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    RootViewController *rootViewController=[[RootViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:rootViewController];
    navigationController.view.backgroundColor=[UIColor brownColor];
    
#warning 需要显式调用这一句，才能使自定义动画中iOS7以后的Push、CoverIn和从CoverReveal动画正常使用
    [navigationController enableTransition];
    self.window.rootViewController=navigationController;
//    navigationController.navigationBarHidden=true;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

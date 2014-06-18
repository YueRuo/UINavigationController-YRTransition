//
//  UINavigationController+YRTransition.h
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTransition.h"

@interface UINavigationController (YRTransition)
-(void)pushViewController:(UIViewController *)viewController withYRTransition:(YRTransition*)transition;

-(UIViewController *)popViewControllerWithYRTransition:(YRTransition*)transition;
-(NSArray *)popToViewController:(UIViewController *)viewController withYRTransition:(YRTransition*)transition;
-(NSArray *)popToRootViewControllerWithYRTransition:(YRTransition*)transition;
@end

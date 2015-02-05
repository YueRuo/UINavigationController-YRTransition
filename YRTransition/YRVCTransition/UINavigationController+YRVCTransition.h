//
//  UINavigationController+YRVCTransition.h
//  YRVCTransitionDemo
//
//  Created by 王晓宇 on 14-10-10.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRVCTransition.h"
#import "YRPercentDrivenInteractiveTransition.h"

/*!
 *	@brief	iOS7之后的高级交互式切换动画
 *
 */
@interface UINavigationController (YRVCTransition)<UINavigationControllerDelegate>

@property (retain,nonatomic) YRPercentDrivenInteractiveTransition *interactiveYRTransition  NS_AVAILABLE_IOS(7_0);//gesture

-(void)bindYRTransitionDelegate NS_AVAILABLE_IOS(7_0);//need call after init if you want the animation


-(void)pushViewController:(UIViewController *)viewController withYRVCTransition:(YRVCTransition*)transition NS_AVAILABLE_IOS(7_0);
-(UIViewController *)popViewControllerWithYRVCTransition:(YRVCTransition*)transition  NS_AVAILABLE_IOS(7_0);
-(NSArray *)popToViewController:(UIViewController *)viewController withYRVCTransition:(YRVCTransition*)transition  NS_AVAILABLE_IOS(7_0);
-(NSArray *)popToRootViewControllerWithYRVCTransition:(YRVCTransition*)transition  NS_AVAILABLE_IOS(7_0);
@end

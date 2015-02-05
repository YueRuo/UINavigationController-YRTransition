//
//  UINavigationController+YRTransition.h
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTransition.h"

/*!
 *	@brief	最低支持版本iOS4.0，放心使用，内部实现上，对于高于7的方法调用YRVCTransition库，低的则使用CATransiton实现
 */
@interface UINavigationController (YRTransition)

-(void)enableTransition;//启用动画,并启用右滑返回前一界面功能
-(void)setPanToPreViewEnable:(BOOL)enable;//开关左滑返回上一层功能

-(void)pushViewController:(UIViewController *)viewController withYRTransition:(YRTransition*)transition;

-(UIViewController *)popViewControllerWithYRTransition:(YRTransition*)transition;
-(NSArray *)popToViewController:(UIViewController *)viewController withYRTransition:(YRTransition*)transition;
-(NSArray *)popToRootViewControllerWithYRTransition:(YRTransition*)transition;
@end

//
//  UIViewContrller+YRTransition.h
//  YRVCRouter
//
//  Created by 王晓宇 on 15/2/4.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRTransition.h"

/*!
 *	@brief	最低支持版本iOS4.0，放心使用
 */
@interface UIViewController (YRTransition)

-(void)presentViewController:(UIViewController *)viewControllerToPresent transition:(YRTransition *)transition completion:(void (^)(void))completion;
-(void)dismissViewControllerWithYRTransition:(YRTransition *)transition completion:(void (^)(void))completion;

@end

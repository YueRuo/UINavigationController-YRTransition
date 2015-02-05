//
//  UIViewController+YRVCTransition.h
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
@interface UIViewController (YRVCTransition)<UIViewControllerTransitioningDelegate>

@property (retain,nonatomic) YRPercentDrivenInteractiveTransition *interactiveYRTransition NS_AVAILABLE_IOS(7_0);//gesture
@property (retain,nonatomic) YRVCTransition *transition NS_AVAILABLE_IOS(7_0);//animation
@property (assign,nonatomic) YRVCTransitionSwipeDir swipeDir NS_AVAILABLE_IOS(7_0);//the back gesture dir


@property (assign,nonatomic) BOOL enableBackGesture NS_AVAILABLE_IOS(7_0);//gesture enable , default is YES

@end

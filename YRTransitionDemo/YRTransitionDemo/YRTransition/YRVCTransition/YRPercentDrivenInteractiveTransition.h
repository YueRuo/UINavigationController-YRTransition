//
//  YRPercentDrivenInteractiveTransition.h
//  Mark
//
//  Created by 王晓宇 on 14-10-9.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

/*!
 *	@brief	the interaction when you use gesture to pop or dismiss a viewController.
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YRTransitonStyle) {
    YRTransitonStyle_Navi,//use NavigationController
    YRTransitonStyle_Model,//use ModelViewController
};

typedef NS_ENUM(NSUInteger, YRVCTransitionSwipeDir) {
    YRVCTransitionSwipeDir_Top2Bottom,
    YRVCTransitionSwipeDir_Left2Right,
    YRVCTransitionSwipeDir_Bottom2Top,
    YRVCTransitionSwipeDir_Right2Left,
};

@interface YRPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (assign,nonatomic) BOOL inProgress;
@property (assign,nonatomic) YRVCTransitionSwipeDir swipeDir;
@property (assign,nonatomic) BOOL enable;

-(void)addTransitionToViewController:(UIViewController*)viewController transitionSourceVC:(UIViewController*)sourceVC style:(YRTransitonStyle)style;

@end

//
//  YRReversibleVCTransitioning.h
//  Mark
//
//  Created by 王晓宇 on 14-10-9.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YRVCTransitionDirection) {
    YRVCTransitionDirection_FromTop,
    YRVCTransitionDirection_FromLeft,
    YRVCTransitionDirection_FromBottom,
    YRVCTransitionDirection_FromRight,
};

NS_CLASS_AVAILABLE_IOS(7_0) @interface YRVCTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign,nonatomic) NSTimeInterval duration;
@property (assign,nonatomic) YRVCTransitionDirection direction;
@property (assign,nonatomic) BOOL reverse;

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView*)fromView toView:(UIView*)toView;

@end

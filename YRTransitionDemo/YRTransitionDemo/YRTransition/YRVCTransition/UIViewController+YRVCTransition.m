//
//  UIViewController+YRVCTransition.m
//  YRVCTransitionDemo
//
//  Created by 王晓宇 on 14-10-10.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "UIViewController+YRVCTransition.h"
#import <objc/runtime.h>
#import "UINavigationController+YRVCTransition.h"

static const char *assoKeyInteractiveTransition = "assoKeyNavInteractiveTransition";
static const char *assoKeyTransition = "assoKeyTransition";
static const char *assoKeyInteractiveSwipeDir = "assoKeyInteractiveSwipeDir";
static const char *assoKeyEnableBackGesture = "assoKeyEnableBackGesture";

@implementation UIViewController (YRVCTransition)

-(YRPercentDrivenInteractiveTransition *)interactiveYRTransition{
    return objc_getAssociatedObject(self, assoKeyInteractiveTransition);
}

-(void)setInteractiveYRTransition:(YRPercentDrivenInteractiveTransition *)interactiveTransition{
    objc_setAssociatedObject(self, assoKeyInteractiveTransition, interactiveTransition, OBJC_ASSOCIATION_RETAIN);
}

-(YRVCTransition *)transition{
    return objc_getAssociatedObject(self, assoKeyTransition);
}

-(void)setTransition:(YRVCTransition *)transition{
    objc_setAssociatedObject(self, assoKeyTransition, transition, OBJC_ASSOCIATION_RETAIN);
    if ([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]!=NSOrderedAscending) {
        self.transitioningDelegate=self;
    }
}

-(YRVCTransitionSwipeDir)swipeDir{
    NSNumber *dirNum = objc_getAssociatedObject(self, assoKeyInteractiveSwipeDir);
    if (dirNum) {
        return [dirNum intValue];
    }
    return YRVCTransitionSwipeDir_Left2Right;
}

-(void)setSwipeDir:(YRVCTransitionSwipeDir)swipeDir{
    objc_setAssociatedObject(self, assoKeyInteractiveSwipeDir, [NSNumber numberWithInt:swipeDir], OBJC_ASSOCIATION_RETAIN);
    if (self.navigationController.topViewController == self) {
        [self.navigationController.interactiveYRTransition setSwipeDir:swipeDir];
    }
}

-(BOOL)enableBackGesture{
    NSNumber *enableNum = objc_getAssociatedObject(self, assoKeyEnableBackGesture);
    if (enableNum) {
        return [enableNum boolValue];
    }
    return true;
}

-(void)setEnableBackGesture:(BOOL)enableBackGesture{
    objc_setAssociatedObject(self, assoKeyEnableBackGesture, [NSNumber numberWithBool:enableBackGesture], OBJC_ASSOCIATION_RETAIN);
    if (self.navigationController.topViewController == self) {
        [self.navigationController.interactiveYRTransition setEnable:enableBackGesture];
    }
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.transition;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    YRVCTransition *t=self.transition;
    t.reverse=!t.reverse;
    return t;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveYRTransition&&self.interactiveYRTransition.inProgress?self.interactiveYRTransition:nil;
    
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveYRTransition&&self.interactiveYRTransition.inProgress?self.interactiveYRTransition:nil;
    
}

@end

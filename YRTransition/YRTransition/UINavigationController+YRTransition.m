//
//  UINavigationController+YRTransition.m
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import "UINavigationController+YRTransition.h"
#import "UIView+YRTransition.h"
#import "UINavigationController+YRVCTransition.h"
#import "YRVCTransitionMoveIn.h"
#import "UINavigationController+YRBackGesture.h"


@implementation UINavigationController (YRTransition)

-(void)setBackGestureEnable:(BOOL)enable{
    if (IOS7_OR_LATER) {
        [self bindYRTransitionDelegate];
        self.interactivePopGestureRecognizer.enabled = false;
    }else{
        [self setEnableBackGesture:enable];
    }
}

-(void)pushViewController:(UIViewController *)viewController withYRTransition:(YRTransition *)transition{
    if ([transition isSystemAnimation]) {
        [self.view addYRTransition:transition];
        [self pushViewController:viewController animated:false];
    }else{//对接iOS7之后的动画库
        YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
        moveIn.duration = transition.duration;
        moveIn.direction = (YRVCTransitionDirection)transition.direction;//数值是对应的
        if(transition.type==YRTransitionType_CoverReveal){
            moveIn.reverse = true;
        }
        [self pushViewController:viewController withYRVCTransition:moveIn];
    }
}

-(UIViewController *)popViewControllerWithYRTransition:(YRTransition *)transition{
    NSInteger count=[[self viewControllers]count];
    if (count<=1) {
        NSLog(@"warning: no viewController can be poped");
        return nil;
    }
    if ([transition isSystemAnimation]) {
        [self.view addYRTransition:transition];
        return [self popViewControllerAnimated:false];
    }else{
        YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
        moveIn.duration = transition.duration;
        moveIn.direction = (YRVCTransitionDirection)transition.direction;//数值是对应的
        switch (transition.direction) {
            case YRTransitionDirection_FromLeft:
                moveIn.direction = YRVCTransitionDirection_FromRight;
                break;
            case YRTransitionDirection_FromRight:
                moveIn.direction = YRVCTransitionDirection_FromLeft;
                break;
            default:
                break;
        }
        if(transition.type==YRTransitionType_CoverReveal){
            moveIn.reverse = false;
        }else{
            moveIn.reverse = true;
        }
        return [self popViewControllerWithYRVCTransition:moveIn];
    }
}
-(NSArray *)popToViewController:(UIViewController *)viewController withYRTransition:(YRTransition *)transition{
    NSInteger count=[[self viewControllers]count];
    if (count<=1) {
        NSLog(@"warning: no viewController can be poped");
        return nil;
    }
    NSInteger nextIndex=[[self viewControllers]indexOfObject:viewController];
    if (nextIndex<0) {
        NSLog(@"warining: try to pop to a viewController not in navigationController");
        return nil;
    }
    NSInteger popedCount=count-nextIndex-1;
    if (popedCount==0) {
        NSLog(@"warning: try to pop to the current viewController");
    }
    if ([transition isSystemAnimation]) {
        [self.view addYRTransition:transition];
        return [self popToViewController:viewController animated:false];
    }else{
        YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
        moveIn.duration = transition.duration;
        moveIn.direction = (YRVCTransitionDirection)transition.direction;//数值是对应的
        switch (transition.direction) {
            case YRTransitionDirection_FromLeft:
                moveIn.direction = YRVCTransitionDirection_FromRight;
                break;
            case YRTransitionDirection_FromRight:
                moveIn.direction = YRVCTransitionDirection_FromLeft;
                break;
            default:
                break;
        }
        if(transition.type==YRTransitionType_CoverReveal){
            moveIn.reverse = false;
        }else{
            moveIn.reverse = true;
        }
        return [self popToViewController:viewController withYRVCTransition:moveIn];
    }
}
-(NSArray *)popToRootViewControllerWithYRTransition:(YRTransition *)transition{
    return [self popToViewController:self.viewControllers.firstObject withYRTransition:transition];
}
@end

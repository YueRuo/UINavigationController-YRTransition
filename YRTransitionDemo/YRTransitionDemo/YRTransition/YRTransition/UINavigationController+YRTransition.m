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

-(void)enableTransition{
    if ([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]!=NSOrderedAscending) {
        [self bindYRTransitionDelegate];
        self.interactivePopGestureRecognizer.enabled = false;
    }else{
        [self setEnableBackGesture:true];
    }
}
-(void)setPanToPreViewEnable:(BOOL)enable{
    if ([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]!=NSOrderedAscending) {
        self.interactiveYRTransition = enable?[YRPercentDrivenInteractiveTransition new]:nil;
    }else{
        [self setEnableBackGesture:enable];
    }
}

-(void)pushViewController:(UIViewController *)viewController withYRTransition:(YRTransition *)transition{
    if ([transition isSystemAnimation]) {
        [self.view addYRTransition:transition];
        [self pushViewController:viewController animated:false];
    }else{//对接iOS7之后的动画库
        YRVCTransition *moveIn = [transition toVCTransitionPush];
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
        YRVCTransition *vcTransition=[transition toVCTransitionPop];
        return [self popViewControllerWithYRVCTransition:vcTransition];
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
        YRVCTransition *vcTransition = [transition toVCTransitionPop];
        return [self popToViewController:viewController withYRVCTransition:vcTransition];
    }
}
-(NSArray *)popToRootViewControllerWithYRTransition:(YRTransition *)transition{
    return [self popToViewController:self.viewControllers.firstObject withYRTransition:transition];
}
@end

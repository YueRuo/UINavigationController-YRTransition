//
//  UINavigationController+YRVCTransition.m
//  YRVCTransitionDemo
//
//  Created by 王晓宇 on 14-10-10.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "UINavigationController+YRVCTransition.h"
#import "UIViewController+YRVCTransition.h"
#import <objc/runtime.h>

static const char *assoKeyInteractiveTransition = "assoKeyNavInteractiveTransition";
static const char *assoKeyDelegate = "assoKeyDelegate";

@interface YRNavigationControllerTransitionDelegate : NSObject<UINavigationControllerDelegate>

@end
@implementation YRNavigationControllerTransitionDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    [navigationController.interactiveYRTransition addTransitionToViewController:toVC transitionSourceVC:fromVC style:YRTransitonStyle_Navi];
    switch (operation) {
        case UINavigationControllerOperationPush:
            return toVC.transition;
        case UINavigationControllerOperationPop:
            fromVC.transition.reverse = !fromVC.transition.reverse;
            return fromVC.transition;
        default:
            break;
    }
    return nil;
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return navigationController.interactiveYRTransition&&navigationController.interactiveYRTransition.inProgress?navigationController.interactiveYRTransition:nil;
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    navigationController.interactiveYRTransition.swipeDir = viewController.swipeDir;
}
@end

@implementation UINavigationController (YRVCTransition)

-(YRPercentDrivenInteractiveTransition *)interactiveYRTransition{
    return objc_getAssociatedObject(self, assoKeyInteractiveTransition);
}

-(void)setInteractiveYRTransition:(YRPercentDrivenInteractiveTransition *)interactiveTransition{
    objc_setAssociatedObject(self, assoKeyInteractiveTransition, interactiveTransition, OBJC_ASSOCIATION_RETAIN);
}
-(void)bindYRTransitionDelegate{
    id delegate = objc_getAssociatedObject(self, assoKeyDelegate);
    if (!delegate) {
        delegate = [[YRNavigationControllerTransitionDelegate alloc]init];
        objc_setAssociatedObject(self, assoKeyDelegate, delegate, OBJC_ASSOCIATION_RETAIN);
    }
    self.delegate = delegate;
    self.interactiveYRTransition = [YRPercentDrivenInteractiveTransition new];
}

-(void)pushViewController:(UIViewController *)viewController withYRVCTransition:(YRVCTransition*)transition{
    viewController.transition = transition;
    [self pushViewController:viewController animated:true];
}
-(UIViewController *)popViewControllerWithYRVCTransition:(YRVCTransition*)transition{
    UIViewController *lastVC = [self topViewController];
    lastVC.transition = transition;
    return [self popViewControllerAnimated:true];
}
-(NSArray *)popToViewController:(UIViewController *)viewController withYRVCTransition:(YRVCTransition*)transition{
    UIViewController *lastVC = [self topViewController];
    lastVC.transition = transition;
    return [self popToViewController:viewController animated:true];
}
-(NSArray *)popToRootViewControllerWithYRVCTransition:(YRVCTransition*)transition{
    UIViewController *lastVC = [self topViewController];
    lastVC.transition = transition;
    return [self popToRootViewControllerAnimated:true];
}
@end
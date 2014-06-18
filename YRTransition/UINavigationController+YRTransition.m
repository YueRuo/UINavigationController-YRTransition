//
//  UINavigationController+YRTransition.m
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import "UINavigationController+YRTransition.h"
#import "UIView+YRTransition.h"

@implementation UINavigationController (YRTransition)

-(void)pushViewController:(UIViewController *)viewController withYRTransition:(YRTransition *)transition{
    if ([transition isSystemAnimation]) {
        [self.view addYRTransition:transition];
        [self pushViewController:viewController animated:false];
    }else{
        __weak typeof(self) weakSelf=self;
        [self.topViewController.view addYRTransition:transition withView:viewController.view completion:^{
            [viewController.view removeFromSuperview];
            [weakSelf pushViewController:viewController animated:false];
        }];
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
        UIViewController *popedViewController=[[self viewControllers]objectAtIndex:count-1];
        UIViewController *nextViewController=[[self viewControllers]objectAtIndex:count-2];
        __weak typeof(self) weakSelf=self;
        [popedViewController.view addYRTransition:transition withView:nextViewController.view completion:^{
            [weakSelf popViewControllerAnimated:false];
        }];
        return popedViewController;
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
        NSMutableArray *popedViewControllers=[NSMutableArray arrayWithCapacity:popedCount];
        for (NSInteger i=nextIndex+1; i<count; i++) {
            [popedViewControllers addObject:[[self viewControllers] objectAtIndex:i]];
        }
        UIViewController *nextViewController=viewController;
        __weak typeof(self) weakSelf=self;
        [self.topViewController.view addYRTransition:transition withView:nextViewController.view completion:^{
            [weakSelf popToViewController:viewController animated:false];
        }];
        return popedViewControllers;
    }
}
-(NSArray *)popToRootViewControllerWithYRTransition:(YRTransition *)transition{
    return [self popToViewController:self.viewControllers.firstObject withYRTransition:transition];
}
@end

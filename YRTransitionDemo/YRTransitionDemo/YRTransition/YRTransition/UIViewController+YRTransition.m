//
//  UIViewContrller+YRTransition.m
//  YRVCRouter
//
//  Created by 王晓宇 on 15/2/4.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import "UIViewController+YRTransition.h"
#import "YRVCTransitionMoveIn.h"
#import "UIViewController+YRVCTransition.h"
#import "UIView+YRTransition.h"

@implementation UIViewController (YRTransition)

-(void)presentViewController:(UIViewController *)viewController transition:(YRTransition *)transition completion:(void (^)(void))completion{
    BOOL animted = false;
    if ([transition isSystemAnimation]) {
        [[[UIApplication sharedApplication]keyWindow]addYRTransition:transition];
    }else{//对接iOS7之后的动画库
        if(transition){
            YRVCTransitionMoveIn *moveIn = [transition toVCTransitionPush];
            viewController.transition = moveIn;
            animted = true;
        }
    }
    [self presentViewController:viewController animated:animted completion:completion];
}

-(void)dismissViewControllerWithYRTransition:(YRTransition *)transition completion:(void (^)(void))completion{
    BOOL animted = false;
    if ([transition isSystemAnimation]) {
        [[[UIApplication sharedApplication]keyWindow]addYRTransition:transition];
    }else{
        YRVCTransitionMoveIn *moveIn = [transition toVCTransitionPop];
        self.transition = moveIn;
        animted = true;
    }
    [self dismissViewControllerAnimated:animted completion:completion];
}
@end

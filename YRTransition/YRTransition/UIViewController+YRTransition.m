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
            YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
            moveIn.duration = transition.duration;
            moveIn.parallaxRatio = 0.5;
            moveIn.direction = (YRVCTransitionDirection)transition.direction;//数值是对应的
            if(transition.type==YRTransitionType_CoverReveal){
                moveIn.reverse = true;
            }
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
        YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
        moveIn.duration = transition.duration;
        moveIn.parallaxRatio = 0.5;
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
        self.transition = moveIn;
        animted = true;
    }
    [self dismissViewControllerAnimated:animted completion:completion];
}
@end

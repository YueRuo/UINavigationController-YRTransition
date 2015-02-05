//
//  YRVCTransitionMoveIn.m
//  Mark
//
//  Created by 王晓宇 on 14-10-10.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRVCTransitionMoveIn.h"

@implementation YRVCTransitionMoveIn

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView{
    UIView *containerView = [transitionContext containerView];
    
    CGRect frame = containerView.bounds;
    CGRect parallaxFrame = frame;
    
    switch (self.direction) {
        case YRVCTransitionDirection_FromTop:{
            frame = ({
                frame.origin.y = -frame.size.height;
                frame;});
            break;}
        case YRVCTransitionDirection_FromLeft:{
            frame = ({
                frame.origin.x = -frame.size.width;
                frame;});
            break;}
        case YRVCTransitionDirection_FromBottom:{
            frame = ({
                frame.origin.y = frame.size.height;
                frame;});
            break;}
        case YRVCTransitionDirection_FromRight:{
            frame = ({
                frame.origin.x = frame.size.width;
                frame;});
            break;}
        default:
            break;
    }
    self.parallaxRatio = fminf(1.0, fmaxf(self.parallaxRatio, 0.0));

    parallaxFrame = ({
        parallaxFrame.origin.x = -frame.origin.x*self.parallaxRatio;
        parallaxFrame.origin.y = -frame.origin.y*self.parallaxRatio;
        parallaxFrame;});
    if (self.reverse) {
        fromView.frame = containerView.bounds;
        toView.frame = parallaxFrame;
        [containerView insertSubview:toView belowSubview:fromView];
    }else{
        toView.frame = frame;
        [containerView addSubview:toView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (self.reverse) {
            fromView.frame = frame;
        }else{
            fromView.frame = parallaxFrame;
        }
        toView.frame = containerView.bounds;
    } completion:^(BOOL finished) {
        fromView.frame = containerView.bounds;
        toView.frame = containerView.bounds;
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        }else{
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end

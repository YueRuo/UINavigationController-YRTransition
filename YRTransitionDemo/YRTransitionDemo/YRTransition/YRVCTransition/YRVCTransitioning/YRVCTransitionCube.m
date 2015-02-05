//
//  YRVCTransitionCube.m
//  Mark
//
//  Created by 王晓宇 on 14-10-9.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRVCTransitionCube.h"

#define PERSPECTIVE (-1.0/200.0)
#define ROTATION_ANGLE M_PI_2


@implementation YRVCTransitionCube
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView{
    int dir = self.reverse?1:-1;
    
    CATransform3D viewFromTransform;
    CATransform3D viewToTransform;
    
    UIView *containerView = [transitionContext containerView];
    
    switch (self.direction) {
        case YRVCTransitionDirection_FromTop:{
            viewFromTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 1.0, 0.0, 0.0);
            viewToTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 1.0, 0.0, 0.0);
            [toView.layer setAnchorPoint:CGPointMake(0.5, dir==1?0:1)];
            [fromView.layer setAnchorPoint:CGPointMake(0.5, dir==1?1:0)];
            [containerView setTransform:CGAffineTransformMakeTranslation(0, dir*containerView.frame.size.height/2.0)];
            break;}
        case YRVCTransitionDirection_FromLeft:{
            viewFromTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 0.0, 1.0, 0.0);
            viewToTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 0.0, 1.0, 0.0);
            [fromView.layer setAnchorPoint:CGPointMake(dir==1?1:0, 0.5)];
            [toView.layer setAnchorPoint:CGPointMake(dir==1?0:1, 0.5)];
            [containerView setTransform:CGAffineTransformMakeTranslation(dir*containerView.frame.size.width/2.0, 0)];
            break;}
        case YRVCTransitionDirection_FromBottom:{
            viewFromTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 1.0, 0.0, 0.0);
            viewToTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 1.0, 0.0, 0.0);
            [toView.layer setAnchorPoint:CGPointMake(0.5, dir==1?1:0)];
            [fromView.layer setAnchorPoint:CGPointMake(0.5, dir==1?0:1)];
            [containerView setTransform:CGAffineTransformMakeTranslation(0, -dir*containerView.frame.size.height/2.0)];
            break;}
        case YRVCTransitionDirection_FromRight:{
            viewFromTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 0.0, 1.0, 0.0);
            viewToTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 0.0, 1.0, 0.0);
            [fromView.layer setAnchorPoint:CGPointMake(dir==1?0:1, 0.5)];
            [toView.layer setAnchorPoint:CGPointMake(dir==1?1:0, 0.5)];
            [containerView setTransform:CGAffineTransformMakeTranslation(-dir*containerView.frame.size.width/2.0, 0)];
            break;}
        default:
            break;
    }
    viewFromTransform.m34 = PERSPECTIVE;
    viewToTransform.m34 = PERSPECTIVE;
    
    toView.layer.transform = viewToTransform;
    
    //shadow
    UIView *fromShadow = [self addShadowToView:fromView color:[UIColor blackColor]];
    UIView *toShadow = [self addShadowToView:toView color:[UIColor blackColor]];
    [fromShadow setAlpha:0.0];
    [toShadow setAlpha:1.0];
    
    [containerView addSubview:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        switch (self.direction) {
            case YRVCTransitionDirection_FromTop:{
                [containerView setTransform:CGAffineTransformMakeTranslation(0, -dir*containerView.frame.size.height/2.0)];
                break;}
            case YRVCTransitionDirection_FromLeft:{
                [containerView setTransform:CGAffineTransformMakeTranslation(-dir*containerView.frame.size.width/2.0, 0)];
                break;}
            case YRVCTransitionDirection_FromBottom:{
                [containerView setTransform:CGAffineTransformMakeTranslation(0, dir*containerView.frame.size.height/2.0)];
                break;}
            case YRVCTransitionDirection_FromRight:{
                [containerView setTransform:CGAffineTransformMakeTranslation(dir*containerView.frame.size.width/2.0, 0)];
                break;}
            default:
                break;
        }
        fromView.layer.transform = viewFromTransform;
        toView.layer.transform = CATransform3DIdentity;
        
        [fromShadow setAlpha:1.0];
        [toShadow setAlpha:0.0];
    } completion:^(BOOL finished) {
        [containerView setTransform:CGAffineTransformIdentity];
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        [fromView.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
        [toView.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
        
        [fromShadow removeFromSuperview];
        [toShadow removeFromSuperview];
        
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        }else{
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

-(UIView*)addShadowToView:(UIView*)view color:(UIColor*)color{
    UIView *shadowView = [[UIView alloc]initWithFrame:view.bounds];
    shadowView.backgroundColor = color;
    [view addSubview:shadowView];
    return shadowView;
}
@end

//
//  UIView+YRTransition.m
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import "UIView+YRTransition.h"

@implementation UIView (YRTransition)
-(void)addYRTransition:(YRTransition *)transition{
    [self addYRTransition:transition withView:nil completion:nil];
}
-(void)addYRTransition:(YRTransition *)transition withView:(UIView*)view completion:(void(^)(void))completion{
    if (!transition||![transition isKindOfClass:[YRTransition class]]) {
        return;
    }
    //自定义动画使用viewAnimation
    
    //******************************
    //*-begin-- 自定义动画使用viewAnimation
    //******************************
    if (![transition isSystemAnimation]) {
        if (transition.type==YRTransitionType_CoverIn) {
            [self.superview addSubview:view];
            CGRect frame=self.frame;
            switch (transition.direction) {
                case YRTransitionDirection_FromBottom:{
                    frame.origin.y=-self.frame.size.height;
                    break;}
                case YRTransitionDirection_FromTop:{
                    frame.origin.y=self.frame.size.height;
                    break;}
                case YRTransitionDirection_FromLeft:{
                    frame.origin.x=-self.frame.size.width;
                    break;}
                case YRTransitionDirection_FromRight:{
                    frame.origin.x=self.frame.size.width;
                    break;}
                default:
                    break;
            }
            view.frame=frame;
            [UIView animateWithDuration:transition.duration animations:^{
                view.frame=self.frame;
            } completion:^(BOOL finished) {
                view.frame=self.frame;
                if (completion) {
                    completion();
                }
            }];
        }else if (transition.type==YRTransitionType_CoverReveal){
            [self.superview insertSubview:view belowSubview:self];
            CGRect frame=self.frame;
            view.frame=self.frame;
            switch (transition.direction) {
                case YRTransitionDirection_FromBottom:{
                    frame.origin.y=self.frame.size.height;
                    break;}
                case YRTransitionDirection_FromTop:{
                    frame.origin.y=-self.frame.size.height;
                    break;}
                case YRTransitionDirection_FromLeft:{
                    frame.origin.x=self.frame.size.width;
                    break;}
                case YRTransitionDirection_FromRight:{
                    frame.origin.x=-self.frame.size.width;
                    break;}
                default:
                    break;
            }
            [UIView animateWithDuration:transition.duration animations:^{
                self.frame=frame;
            } completion:^(BOOL finished) {
                self.frame=view.frame;
                [view removeFromSuperview];
                [self.superview addSubview:view];
                if (completion) {
                    completion();
                }
            }];
        }
        return;
    }
    //----------------------------
    //-end-- 自定义动画使用viewAnimation
    //---------------------------
    
    
    //******************************
    //*-begin-- 系统动画使用CATransition
    //******************************
    CATransition *animation = [CATransition animation];
    animation.duration =[transition duration];
    [animation setRemovedOnCompletion:true];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    switch ([transition type]) {
        case YRTransitionType_Fade:
            animation.type = kCATransitionFade;
            break;
        case YRTransitionType_Push:
            animation.type = kCATransitionPush;
            break;
        case YRTransitionType_Reveal:
            animation.type = kCATransitionReveal;
            break;
        case YRTransitionType_MoveIn:
            animation.type = kCATransitionMoveIn;
            break;
        case YRTransitionType_Cube:
            animation.type = @"cube";
            break;
        case YRTransitionType_SuckEffect:
            animation.type = @"suckEffect";
            break;
        case YRTransitionType_OglFlip:
            animation.type = @"oglFlip";
            break;
        case YRTransitionType_RippleEffect:
            animation.type = @"rippleEffect";
            break;
        case YRTransitionType_PageCurl:
            animation.type = @"pageCurl";
            break;
        case YRTransitionType_PageUnCurl:
            animation.type = @"pageUnCurl";
            break;
        case YRTransitionType_CameraIrisHollowOpen:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case YRTransitionType_CameraIrisHollowClose:
            animation.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    switch ([transition direction]) {
        case YRTransitionDirection_FromLeft:
            animation.subtype = kCATransitionFromLeft;
            break;
        case YRTransitionDirection_FromBottom:
            animation.subtype = kCATransitionFromBottom;
            break;
        case YRTransitionDirection_FromRight:
            animation.subtype = kCATransitionFromRight;
            break;
        case YRTransitionDirection_FromTop:
            animation.subtype = kCATransitionFromTop;
            break;
        default:
            break;
    }
    [[self layer] addAnimation:animation forKey:@"animation"];
    if (completion) {
        completion();
    }
    //----------------------------
    //-end-- 系统动画使用CATransition
    //---------------------------
}
@end

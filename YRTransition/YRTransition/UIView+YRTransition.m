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
        case YRTransitionType_CoverReveal:
            animation.type = kCATransitionReveal;
            break;
        case YRTransitionType_MoveIn:
        case YRTransitionType_CoverIn:
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

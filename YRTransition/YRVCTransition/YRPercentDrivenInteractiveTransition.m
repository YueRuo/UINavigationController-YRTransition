//
//  YRPercentDrivenInteractiveTransition.m
//  Mark
//
//  Created by 王晓宇 on 14-10-9.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRPercentDrivenInteractiveTransition.h"
#import "UIViewController+YRVCTransition.h"
#import "YRVCRouter.h"

#define YRVC_TRANSITION_TOTAL_DISTANCE 300.0

@interface YRPercentDrivenInteractiveTransition ()
@property (retain,nonatomic) UIPanGestureRecognizer *gesture;
@property (weak,nonatomic) UIViewController *viewController;
@property (assign,nonatomic) YRTransitonStyle style;


@end

@implementation YRPercentDrivenInteractiveTransition
-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}
-(void)dealloc{
    [_gesture.view removeGestureRecognizer:_gesture];
}
-(void)addTransitionToViewController:(UIViewController *)viewController style:(YRTransitonStyle)style{
    _viewController = viewController;
    _style = style;
    [self setEnable:viewController.enableBackGesture];
}

-(void)setEnable:(BOOL)enable{
    _enable = enable;
    if (enable) {
        if (_viewController.enableBackGesture) {
            switch (_style) {
                case YRTransitonStyle_Navi:
                    [_viewController.navigationController.view addGestureRecognizer:self.gesture];
                    break;
                default:
                    [_viewController.view addGestureRecognizer:self.gesture];
                    break;
            }
        }
    }else{
        [_gesture.view removeGestureRecognizer:_gesture];
    }
}

-(CGFloat)completionSpeed{
    return 1-self.percentComplete;
}

-(UIPanGestureRecognizer *)gesture{
    if (!_gesture) {
        _gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    }
    return _gesture;
}

-(void)handleGesture:(UIPanGestureRecognizer*)gesture{
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    CGPoint vel = [gesture translationInView:gesture.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            BOOL shouldStart=false;
            switch (self.swipeDir) {
                case YRVCTransitionSwipeDir_Left2Right:{
                    shouldStart = vel.x>0;
                    break;}
                case YRVCTransitionSwipeDir_Right2Left:{
                    shouldStart = vel.x<0;
                    break;}
                case YRVCTransitionSwipeDir_Top2Bottom:{
                    shouldStart = vel.y>0;
                    break;}
                case YRVCTransitionSwipeDir_Bottom2Top:{
                    shouldStart = vel.y<0;
                    break;}
                default:
                    break;
            }
            if (shouldStart) {
                self.inProgress = true;
                switch (_style) {
                    case YRTransitonStyle_Navi:
                        [_viewController.navigationController popViewControllerAnimated:true];
                        break;
                    case YRTransitonStyle_Model:
                        [_viewController dismissViewControllerAnimated:YES completion:nil];
                        break;
                    case YRTransitonStyle_YRVCRouter:{
                        [[YRVCRouter shared]popVCWithYRTransition:[YRTransition transitionWithType:YRTransitionType_CoverReveal direction:YRTransitionDirection_FromLeft]];
                        break;}
                    default:
                        break;
                }
            }
            break;}
        case UIGestureRecognizerStateChanged:{
            if (self.inProgress) {
                CGFloat fraction = 0;
                switch (self.swipeDir) {
                    case YRVCTransitionSwipeDir_Left2Right:
                    case YRVCTransitionSwipeDir_Right2Left:{
                        fraction = fabsf(translation.x/YRVC_TRANSITION_TOTAL_DISTANCE);
                        break;}
                    case YRVCTransitionSwipeDir_Top2Bottom:
                    case YRVCTransitionSwipeDir_Bottom2Top:{
                        fraction = fabsf(translation.y/YRVC_TRANSITION_TOTAL_DISTANCE);
                        break;}
                    default:
                        break;
                }
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                if (fraction>=1.0) {
                    fraction = 0.99;
                }
                [self updateInteractiveTransition:fraction];
            }
            break;}
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            if (self.inProgress) {
                self.inProgress = false;
                if (self.percentComplete<0.4|| gesture.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                    if (_style==YRTransitonStyle_YRVCRouter) {
                        [[[YRVCRouter shared]viewControllers]addObject:_viewController];
                    }
                }else{
                    [self finishInteractiveTransition];
                }
            }
            break;}
        case UIGestureRecognizerStateFailed:{
            if (_style==YRTransitonStyle_YRVCRouter) {
                [[[YRVCRouter shared]viewControllers]addObject:_viewController];
            }
            break;}
        case UIGestureRecognizerStatePossible:{
            break;}
        default:
            break;
    }
}
@end

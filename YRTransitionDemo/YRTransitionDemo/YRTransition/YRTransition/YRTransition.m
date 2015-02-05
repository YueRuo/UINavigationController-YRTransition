//
//  YRTransition.m
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import "YRTransition.h"

@implementation YRTransition
-(id)init{
    if (self=[super init]) {
        _type=YRTransitionType_Fade;
        _duration=0.35f;
    }
    return self;
}

+(YRTransition*)transitionWithType:(YRTransitionType)type{
    return [YRTransition transitionWithType:type direction:YRTransitionDirection_FromLeft duration:0.35];
}
+(YRTransition *)transitionWithType:(YRTransitionType)type duration:(NSTimeInterval)duration{
    return [YRTransition transitionWithType:type direction:YRTransitionDirection_FromLeft duration:duration];
}
+(YRTransition*)transitionWithType:(YRTransitionType)type direction:(YRTransitionDirection)direction{
    return [YRTransition transitionWithType:type direction:direction duration:0.35];
}
+(YRTransition*)transitionWithType:(YRTransitionType)type direction:(YRTransitionDirection)direction duration:(NSTimeInterval)duration{
    YRTransition *transition=[[YRTransition alloc]init];
    [transition setType:type];
    [transition setDirection:direction];
    [transition setDuration:duration];
    return transition;
}

-(BOOL)isSystemAnimation{
    if ([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]!=NSOrderedAscending) {
        switch (_type) {
            case YRTransitionType_Push:
            case YRTransitionType_CoverIn:
            case YRTransitionType_CoverReveal:
                return false;
            default:
                break;
        }
    }
    return true;
}
@end


@implementation YRTransition (YRVCTransitionConvert)
-(YRVCTransitionMoveIn*)toVCTransitionPush{
    if ([self isSystemAnimation]) {
        return nil;
    }
    YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
    moveIn.duration = self.duration;
    switch (self.type) {
        case YRTransitionType_CoverIn:
            moveIn.reverse = false;
            break;
        case YRTransitionType_CoverReveal:
            moveIn.reverse = true;
            break;
        case YRTransitionType_Push:
            moveIn.parallaxRatio = 0.5;
            break;
        default:
            break;
    }
    //系统库的方向是很怪的
    switch (self.direction) {
        case YRTransitionDirection_FromTop:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromTop:YRVCTransitionDirection_FromBottom;
            break;
        case YRTransitionDirection_FromLeft:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromRight:YRVCTransitionDirection_FromLeft;
            break;
        case YRTransitionDirection_FromBottom:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromBottom:YRVCTransitionDirection_FromTop;
            break;
        case YRTransitionDirection_FromRight:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromLeft:YRVCTransitionDirection_FromRight;
            break;
        default:
            break;
    }
    return moveIn;
}
-(YRVCTransitionMoveIn*)toVCTransitionPop{
    if ([self isSystemAnimation]) {
        return nil;
    }
    YRVCTransitionMoveIn *moveIn=[[YRVCTransitionMoveIn alloc]init];
    moveIn.duration = self.duration;
    switch (self.type) {
        case YRTransitionType_CoverIn:
            moveIn.reverse = true;
            break;
        case YRTransitionType_CoverReveal:
            moveIn.reverse = false;
            break;
        case YRTransitionType_Push:
            moveIn.parallaxRatio = 0.5;
            break;
        default:
            break;
    }
    switch (self.direction) {
        case YRTransitionDirection_FromTop:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromBottom:YRVCTransitionDirection_FromTop;
            break;
        case YRTransitionDirection_FromLeft:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromLeft:YRVCTransitionDirection_FromRight;
            break;
        case YRTransitionDirection_FromBottom:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromTop:YRVCTransitionDirection_FromBottom;
            break;
        case YRTransitionDirection_FromRight:
            moveIn.direction = moveIn.reverse?YRVCTransitionDirection_FromRight:YRVCTransitionDirection_FromLeft;
            break;
        default:
            break;
    }
    return moveIn;
}

@end


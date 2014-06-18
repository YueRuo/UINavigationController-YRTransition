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
    switch (_type) {
        case YRTransitionType_CoverIn:
        case YRTransitionType_CoverReveal:
            return false;
        default:
            break;
    }
    return true;
}
@end

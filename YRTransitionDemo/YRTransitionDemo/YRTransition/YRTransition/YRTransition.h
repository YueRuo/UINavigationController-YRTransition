//
//  YRTransition.h
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


//使用最多的是YRTransitionType_Push、YRTransitionType_CoverIn和YRTransitionType_CoverReveal
typedef enum {
    YRTransitionType_Fade=1,//淡入淡出
    YRTransitionType_Push,//推入,高于iOS7系统则使用更高级API
    YRTransitionType_MoveIn,//上层覆盖进入,iOS7下带淡入淡出效果
    YRTransitionType_Reveal,//上层拉出,iOS7下带淡入淡出效果
    YRTransitionType_CoverIn,//上层覆盖进入,下无淡入淡出效果,高于iOS7系统则使用更高级API
    YRTransitionType_CoverReveal,//上层拉出,无淡入淡出效果,高于iOS7系统则使用更高级API
    //private 但能用
    YRTransitionType_Cube,//立方体
    YRTransitionType_SuckEffect,//吸收
    YRTransitionType_OglFlip,//翻转
    YRTransitionType_RippleEffect,//水波纹
    YRTransitionType_PageCurl,//翻页
    YRTransitionType_PageUnCurl,//反翻页
    YRTransitionType_CameraIrisHollowOpen,//镜头开
    YRTransitionType_CameraIrisHollowClose,//镜头关
}YRTransitionType;

typedef enum {
    YRTransitionDirection_FromTop=0,//上
    YRTransitionDirection_FromLeft,//左
    YRTransitionDirection_FromBottom,//下
    YRTransitionDirection_FromRight,//右
}YRTransitionDirection;

@interface YRTransition : NSObject
@property (assign,nonatomic) YRTransitionType type;
@property (assign,nonatomic) YRTransitionDirection direction;
@property (assign,nonatomic) NSTimeInterval duration;
@property (assign,readonly) BOOL isSystemAnimation;//是否是系统动画，如果不是，则可能需要额外处理

+(YRTransition*)transitionWithType:(YRTransitionType)type;
+(YRTransition*)transitionWithType:(YRTransitionType)type duration:(NSTimeInterval)duration;
+(YRTransition*)transitionWithType:(YRTransitionType)type direction:(YRTransitionDirection)direction;
+(YRTransition*)transitionWithType:(YRTransitionType)type direction:(YRTransitionDirection)direction duration:(NSTimeInterval)duration;
@end



#define YRTransitionPush [YRTransition transitionWithType:YRTransitionType_CoverIn direction:YRTransitionDirection_FromRight duration:.35]
#define YRTransitionPop [YRTransition transitionWithType:YRTransitionType_CoverReveal direction:YRTransitionDirection_FromLeft duration:.35]



#import "YRVCTransitionMoveIn.h"
@interface YRTransition (YRVCTransitionConvert)
-(YRVCTransitionMoveIn*)toVCTransitionPush NS_AVAILABLE_IOS(7_0);
-(YRVCTransitionMoveIn*)toVCTransitionPop NS_AVAILABLE_IOS(7_0);
@end









//
//  UIView+YRTransition.h
//  YRSnippets
//
//  Created by 王晓宇 on 13-11-15.
//  Copyright (c) 2013年 王晓宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTransition.h"

@interface UIView (YRTransition)
-(void)addYRTransition:(YRTransition*)transition;
-(void)addYRTransition:(YRTransition *)transition withView:(UIView*)view completion:(void(^)(void))completion;
@end

//
//  YRVCTransitionMoveIn.h
//  Mark
//
//  Created by 王晓宇 on 14-10-10.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRVCTransition.h"

/*!
 *	@brief	if set reverse to YES ,it become MoveOut Animation
 */
@interface YRVCTransitionMoveIn : YRVCTransition


/*!
 *	@brief	value 0.0-1.0 , default is 0.0 , if 0.5 , it seem like Push Animation in iOS7 later
 */
@property (assign,nonatomic) CGFloat parallaxRatio;

@end

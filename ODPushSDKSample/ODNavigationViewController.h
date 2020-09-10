//
//  ODNavigationViewController.h
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/6/3.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODNavigationViewController : UINavigationController

/**
 是否开启侧滑返回 default YES
 */
@property (nonatomic, assign) BOOL enablePopGesture;

@end

NS_ASSUME_NONNULL_END

//
//  UIColor+ODExtension.h
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/18.
//  Copyright © 2020 odin. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ODExtension)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue;

+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END

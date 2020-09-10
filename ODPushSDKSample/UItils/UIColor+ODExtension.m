//
//  UIColor+ODExtension.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/18.
//  Copyright © 2020 odin. All rights reserved.
//

#import "UIColor+ODExtension.h"

@implementation UIColor (ODExtension)

+ (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    NSRange range;
    range.length = 2;
    
    if ([cString length] == 6) {
        // Separate into r, g, b substrings
        //r
        range.location = 0;
        NSString *rString = [cString substringWithRange:range];
        
        //g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        //b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    } else if([cString length] == 8) {
        // Separate into r, g, b substrings
        
        //a
        range.location = 0;
        NSString *aString = [cString substringWithRange:range];
        //r
        range.location = 2;
        NSString *rString = [cString substringWithRange:range];
        
        //g
        range.location = 4;
        NSString *gString = [cString substringWithRange:range];
        
        //b
        range.location = 6;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int a, r, g, b;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
        
    } else {
        return [UIColor clearColor];
    }
}

+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}
@end

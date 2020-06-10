//
//  ODLHomeCell.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/19.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODPHomeCell.h"
#import "UIColor+ODExtension.h"

@implementation ODPHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //加阴影
    self.layer.masksToBounds = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor colorWithRed:38 withGreen:71 withBlue:98 alpha:.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(3,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
    self.layer.shadowOpacity = .3;   //设置阴影透明度
    self.layer.shadowRadius = 5;      //设置阴影圆角
    self.layer.cornerRadius = 8;     //设置视图圆角
}

@end

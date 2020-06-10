//
//  ODPAlertViewController.h
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/26.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ODPAlertViewControllerDelegate <NSObject>

- (void)selectOKWithData:(id)data;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ODPAlertViewController : UIViewController

@property (nonatomic, weak) id<ODPAlertViewControllerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END

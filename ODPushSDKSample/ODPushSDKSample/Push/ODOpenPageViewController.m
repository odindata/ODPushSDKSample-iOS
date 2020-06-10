//
//  ODOpenPageViewController.m
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/26.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODOpenPageViewController.h"
#import <UITextView+WZB.h>
#import "UIColor+ODExtension.h"
#import "MBProgressHUD+Extension.h"
#import <OdinPushSDK/OdinPushSDK.h>

@interface ODOpenPageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *urlTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;

@property (weak, nonatomic) IBOutlet UITextView *contentTxtView;

@end

@implementation ODOpenPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.testBtn.layer.cornerRadius = 2;
    self.testBtn.layer.masksToBounds = YES;
    
    self.contentTxtView.wzb_placeholder = @"填写推送内容(不超过32个字)";
    self.contentTxtView.wzb_placeholderColor = [UIColor colorWithRed:204 withGreen:204 withBlue:204];

    self.contentTxtView.layer.cornerRadius = 2;
    self.contentTxtView.layer.borderWidth = 1;
    self.contentTxtView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    self.contentTxtView.layer.masksToBounds = YES;
    
}

- (IBAction)tesBtnAtction:(id)sender {
    if (self.contentTxtView.text.length < 1 || self.contentTxtView.text.length > 32)
    {
        [MBProgressHUD showTitle:@"内容不能为空或超过32个字符"];
        return;
    }
    
    NSString *content_tmp = [self.contentTxtView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (content_tmp.length == 0)
    {
        [MBProgressHUD showTitle:@"内容不能为空或超过32个字符"];
        return;
    }
    
    NSString *urlStr;
    
    if (self.urlTextFiled.text.length < 1)
    {
        urlStr = @"http://www.odinanalysis.com/";
    }
    else
    {
        if ([self.urlTextFiled.text containsString:@"http"])
        {
            urlStr = self.urlTextFiled.text;
        }
        else
        {
            urlStr = [NSString stringWithFormat:@"http://%@", self.urlTextFiled.text];
        }
    }
    
    BOOL isProductionEnvironment;
#ifdef DEBUG
    isProductionEnvironment = NO;
#else
    isProductionEnvironment = YES;
#endif
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [OdinPush sendMessageWithMessageType:OSendMessageTypeAPNs
                                 content:self.contentTxtView.text
                                   space:0
                 isProductionEnvironment:isProductionEnvironment
                                  extras:@{@"urlkey" : urlStr}
                              linkScheme:nil
                                linkData:nil
                                  result:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (error)
            {
                [MBProgressHUD showTitle:@"发送失败"];
            }
            else
            {
                [MBProgressHUD showTitle:@"发送成功"];
            }
        });
        
    }];
}
@end

//
//  ODRestoreViewController.m
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/26.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODRestoreViewController.h"
#import <UITextView+WZB.h>
#import "UIColor+ODExtension.h"
#import "MBProgressHUD+Extension.h"
#import <LCPushSDK/LCPushSDK.h>

@interface ODRestoreViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTxtView;
@property (weak, nonatomic) IBOutlet UIButton *tetsBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *arrayTitleLbl;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arraySelectImgView;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation ODRestoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tetsBtn.layer.cornerRadius = 2;
    self.tetsBtn.layer.masksToBounds = YES;
    
    self.contentTxtView.wzb_placeholder = @"填写推送内容(不超过32个字)";
      self.contentTxtView.wzb_placeholderColor = [UIColor colorWithRed:204 withGreen:204 withBlue:204];
    self.contentTxtView.layer.cornerRadius = 2;
    self.contentTxtView.layer.borderWidth = 1;
    self.contentTxtView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    self.contentTxtView.layer.masksToBounds = YES;
    
      _path = @"/path/ODPushViewController";
                         _params = @{@"title" : @"App内推送测试" , @"desc" : @"点击测试按钮后，你将立即收到一条app内推送" ,@"msgType" : @2 , @"isTimedPush" : @0 , @"tag" : @1};
}

- (IBAction)testAction:(id)sender {
    if (_contentTxtView.text.length < 1 || _contentTxtView.text.length > 32)
    {
        [MBProgressHUD showTitle:@"内容不能为空或超过32个字符"];
        return;
    }
    NSString *content_tmp = [_contentTxtView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (content_tmp.length == 0)
    {
        [MBProgressHUD showTitle:@"内容不能为空或超过32个字符"];
        return;
    }
    
    BOOL isProductionEnvironment;
#ifdef DEBUG
    isProductionEnvironment = NO;
#else
    isProductionEnvironment = YES;
#endif
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [LCPush sendMessageWithMessageType:OSendMessageTypeAPNs
                                content:_contentTxtView.text
                                  space:0
                isProductionEnvironment:isProductionEnvironment
                                 extras:nil
                             linkScheme:_path
                               linkData:[self convertToJsonData:_params]
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

- (IBAction)linkVcAction:(UIButton *)sender {
    
    for (UILabel *lbTitle in _arrayTitleLbl)
    {
        if (lbTitle.tag == sender.tag)
        {
            lbTitle.textColor = [UIColor colorWithRed:4 withGreen:203 withBlue:148];
        }
        else
        {
            lbTitle.textColor = [UIColor colorWithRed:51 withGreen:51 withBlue:51];
        }
    }
    
    for (UIImageView *selectImg in _arraySelectImgView)
    {
        selectImg.hidden = selectImg.tag != sender.tag;
    }
    
    
    switch (sender.tag) {
        case 0:
        {
            //内推送
            _path = @"/path/ODPushViewController";
                       _params = @{@"title" : @"App内推送测试" , @"desc" : @"点击测试按钮后，你将立即收到一条app内推送" ,@"msgType" : @2 , @"isTimedPush" : @0 , @"tag" : @1};
        }
            break;
        case 1:
        {
            _path = @"/path/ODPushViewController";
                       _params = @{@"title" : @"通知测试" , @"desc" : @"点击测试按钮后，5s左右将收到一条测试通知",@"msgType" : @1 , @"isTimedPush" : @0 , @"tag" : @0};
            //内通知
        }
            break;
        default:
            break;
    }
}


- (NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end

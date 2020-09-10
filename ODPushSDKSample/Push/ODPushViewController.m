//
//  ODPNoteViewController.m
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/25.
//  Copyright © 2020 LC. All rights reserved.
//

#import "ODPushViewController.h"
#import "ODPushHeader.h"
#import "UIColor+ODExtension.h"
#import <UITextView+WZB.h>
#import "ODPTimeTableViewCell.h"
#import <LCPushSDK/LCPush+Test.h>
#import "MBProgressHUD+Extension.h"


@interface ODPushViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *vTitle;
@property (nonatomic, copy) NSString *vDescription;
@property (nonatomic, assign) BOOL isTimedPush;
@property (nonatomic, assign) OSendMessageType messageType;

@property(nonatomic,strong)UITextView *pushContentTxtView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *data;

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) NSInteger timeValue;
@end

@implementation ODPushViewController

#pragma mark ---场景还原---

//点击推送场景还原路径
+ (NSString *)lcPushPath
{
    return @"/path/ODPushViewController";
}

//点击推送场景还原页面参数
- (instancetype)initWithOdinPushScene:(NSDictionary *)params
{
    if (self = [super init])
    {
        //self.params = params;
        self.vTitle = params[@"title"];
        self.messageType = [params[@"msgType"] integerValue];
        self.tag = [params[@"tag"] integerValue];
        self.vDescription = params[@"desc"];
        self.isTimedPush = [params[@"isTimedPush"] boolValue];
    }
    return self;
}



- (instancetype)initWithTitle:(NSString *)title
description:(NSString *)description
messageType:(OSendMessageType)type
                  isTimedPush:(BOOL)isTimedPush{
    return [self initWithTitle:title
             description:description
             messageType:type
             isTimedPush:isTimedPush
                     tag:0];
}

- (instancetype)initWithTitle:(NSString *)title
description:(NSString *)description
messageType:(OSendMessageType)type
                  isTimedPush:(BOOL)isTimedPush tag:(NSInteger)tag{
    if (self = [super init])
    {
        self.vTitle = title;
        self.vDescription = description;
        self.messageType = type;
        self.isTimedPush = isTimedPush;
        self.tag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.vTitle;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.data = @[[NSMutableDictionary dictionaryWithDictionary:@{@"text":@"立即",@"select":@"1"}],
                  [NSMutableDictionary dictionaryWithDictionary:@{@"text":@"1分钟后",@"select":@"0"}],[NSMutableDictionary dictionaryWithDictionary:@{@"text":@"2分钟后",@"select":@"0"}],[NSMutableDictionary dictionaryWithDictionary:@{@"text":@"3分钟后",@"select":@"0"}],[NSMutableDictionary dictionaryWithDictionary:@{@"text":@"4分钟后",@"select":@"0"}]];
    
    [self setupView];
}

- (void)setupView{
    UILabel *tiplbl = [[UILabel  alloc]init];
    tiplbl.numberOfLines = 0;
    tiplbl.text = self.vDescription;
    tiplbl.frame = CGRectMake(16 * PUBLICSCALE, 13, SCREEN_WIDTH - 2 * 16 * PUBLICSCALE, tiplbl.frame.size.height);
    [tiplbl sizeToFit];
    tiplbl.font = [UIFont systemFontOfSize:12];
    tiplbl.textColor = [UIColor colorWithRed:155 withGreen:157 withBlue:165];
    [self.view addSubview:tiplbl];
    
    _pushContentTxtView = [[UITextView alloc]initWithFrame:CGRectMake(16 * PUBLICSCALE, 12 + CGRectGetMaxY(tiplbl.frame), SCREEN_WIDTH - 2 * 16 * PUBLICSCALE, 120)];
    _pushContentTxtView.wzb_placeholder = @"填写推送内容(不超过32个字)";
    _pushContentTxtView.layer.cornerRadius = 2;
    _pushContentTxtView.layer.borderWidth = 1;
    _pushContentTxtView.layer.borderColor = [UIColor colorWithRed:177 withGreen:177 withBlue:177].CGColor;
    
    [self.view addSubview:_pushContentTxtView];
    
 
    //测试btn
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(16 * PUBLICSCALE, 32 + CGRectGetMaxY(_pushContentTxtView.frame), SCREEN_WIDTH - 2 * 16 * PUBLICSCALE, 44)];
    [testBtn setTitle:@"点击测试" forState:0];
    [testBtn setTitleColor:[UIColor whiteColor] forState:0];
    testBtn.backgroundColor = [UIColor colorWithRed:4 withGreen:203 withBlue:148];
    testBtn.layer.cornerRadius = 2;
    [testBtn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    if (self.isTimedPush) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(16 * PUBLICSCALE, 22 + CGRectGetMaxY(_pushContentTxtView.frame), SCREEN_WIDTH - 2 * 16 * PUBLICSCALE, 213)];
        [_tableView registerClass:[ODPTimeTableViewCell class] forCellReuseIdentifier:@"rid"];
        _tableView.rowHeight = 44;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        testBtn.frame = CGRectMake(16 * PUBLICSCALE, 32 + CGRectGetMaxY(_tableView.frame), SCREEN_WIDTH - 2 * 16 * PUBLICSCALE, 44);
    }
}

- (void)testAction:(UIButton *)sender{
    
    BOOL isProductionEnvironment;
#ifdef DEBUG
    isProductionEnvironment = NO;
#else
    isProductionEnvironment = YES;
#endif
    
    if (self.pushContentTxtView.text.length < 1 || self.pushContentTxtView.text.length > 32)
    {
        [MBProgressHUD showTitle:@"内容不能为空或超过32个字符"];
        return;
    }
    NSString *content_tmp = [self.pushContentTxtView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (content_tmp.length == 0)
    {
        [MBProgressHUD showTitle:@"内容不能为空或超过32个字符"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (self.tag == 1) {
        //应用内消息
        [LCPush sendMessageWithMessageType:self.messageType
                                     content:self.pushContentTxtView.text.length ? self.pushContentTxtView.text : self.pushContentTxtView.wzb_placeholder
                                             space:@(self.timeValue)
                           isProductionEnvironment:isProductionEnvironment
                                            extras:nil
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
    }else {
        //本地通知
        if(self.tag == 4){
            LCPushMessage *message = [[LCPushMessage alloc] init];
            message.messageType = OPushMessageTypeLocal;
            LCPushNotification *noti = [[LCPushNotification alloc] init];
            noti.body = self.pushContentTxtView.text;
            noti.title = @"标题";
            noti.subTitle = @"子标题";
//            noti.sound = @"unbelievable.caf";
            noti.badge = ([UIApplication sharedApplication].applicationIconBadgeNumber < 0 ? 0 : [UIApplication sharedApplication].applicationIconBadgeNumber) + 1;
            message.notification = noti;
            
            if (self.timeValue)
            {
                // 设置几分钟后发起本地推送
                NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval nowtime = [currentDate timeIntervalSince1970] * 1000;
                NSTimeInterval taskDate = nowtime + self.timeValue*60*1000;
                message.taskDate = taskDate;
            }
            else
            {
                message.isInstantMessage = YES;
            }
            
            [LCPush addLocalNotification:message];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }else{
            //apns
            [LCPush sendMessageWithMessageType:self.messageType
                                         content:self.pushContentTxtView.text
                                           space:@(self.timeValue)
                         isProductionEnvironment:isProductionEnvironment
                                          extras:@{
                                              @"path": @"https://www.baidu.com/",
                                              @"ordertype": @3,
                                              @"type": @"reservation",
                                              @"id": @"d3e6b3c4-38c7-4e69-9fa7-264a83411718"
                                          }
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
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ODPTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.timeDic = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.data setValue:@"0" forKey:@"select"];
    NSMutableDictionary *timeDic = self.data[indexPath.row];
    timeDic[@"select"] = @"1";
    self.timeValue = indexPath.row;
    [self.tableView reloadData];
}

@end

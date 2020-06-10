//
//  ODHomeViewController.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODPHomeViewController.h"
#import "ODPushHeader.h"
#import "ODPHomeCell.h"
#import "ODPushViewController.h"
#import "ODRestoreViewController.h"
#import "ODOpenPageViewController.h"

@interface ODPHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation ODPHomeViewController

#pragma mark ---场景还原---

//点击推送场景还原路径
+ (NSString *)OdinPushPath
{
    return @"/path/ODPHomeViewController";
}

//点击推送场景还原页面参数
- (instancetype)initWithMobPushScene:(NSDictionary *)params
{
    if (self = [super init])
    {
        //self.params = params;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupView];
}

- (void)setupView{
    self.title = @"Odin Push";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 23*2 - 18) / 2.0, (SCREEN_WIDTH - 23*2 - 18) / 2.0 * 377/311.0);
    flowLayout.minimumLineSpacing = 18;
    flowLayout.minimumInteritemSpacing = 18;
    flowLayout.sectionInset = UIEdgeInsetsMake(23, 23, 0, 18);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StaH - NavH) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ODPHomeCell" bundle:nil] forCellWithReuseIdentifier:@"ReuseIdentifier"];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ODPHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *data = self.dataArray[indexPath.row];
      cell.imgView.image = [UIImage imageNamed:data[@"imgIcon"]];
    cell.typeLbl.text = data[@"type"];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            ODPushViewController *pushVc = [[ODPushViewController alloc]
                                            initWithTitle:@"App内推送测试"
                                            description:@"点击测试按钮后，将立即收到一条App内推送"
                                            messageType:OSendMessageTypeCustom
                                            isTimedPush:NO
                                            tag:1];
            [self.navigationController pushViewController:pushVc animated:YES];
        }
            
            break;
        case 1:{
            ODPushViewController *pushVc = [[ODPushViewController alloc]
                                            initWithTitle:@"App通知测试"
                                       description:@"点击测试按钮后，请在前台关闭App,10s后本手机将收到一条App测试通知提醒"
                                            messageType:OSendMessageTypeAPNs
                                            isTimedPush:NO];
            [self.navigationController pushViewController:pushVc animated:YES];
        }
            
            break;
        case 2:
        {
            ODPushViewController *pushVc = [[ODPushViewController alloc]
                                            initWithTitle:@"定时通知测试"
                                            description:@"设置时间后点击测试按钮，在到设置时间时将收到一条测试通知"
                                            messageType:OSendMessageTypeAPNs
                                            isTimedPush:YES];
            [self.navigationController pushViewController:pushVc animated:YES];
        }
            break;
        case 3:
        {   ODPushViewController *pushVc = [[ODPushViewController alloc]
                                            initWithTitle:@"本地通知测试"
                                            description:@"设置时间后点击测试按钮，在到设置时间时将收到一条测试通知"
                                            messageType:OSendMessageTypeAPNs
                                            isTimedPush:YES
                                            tag:4];
            [self.navigationController pushViewController:pushVc animated:YES];
            
        }
            break;
        case 4:{
            ODOpenPageViewController *openPageVc = [[ODOpenPageViewController alloc]init];
            openPageVc.title = @"推送打开指定链接页面";
            [self.navigationController pushViewController:openPageVc animated:YES];
        }
            break;
            
        case 5:{
            ODRestoreViewController *openPageVc = [[ODRestoreViewController alloc]init];
            openPageVc.title = @"推送打开应用内指定页面";
            [self.navigationController pushViewController:openPageVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[
            @{@"imgIcon":@"home_00",@"type":@"App内推送"},
            @{@"imgIcon":@"home_01",@"type":@"App通知"},
            @{@"imgIcon":@"home_02",@"type":@"定时通知"},
            @{@"imgIcon":@"home_03",@"type":@"本地通知"},
            @{@"imgIcon":@"home_04",@"type":@"推送并打开指定链接"},
            @{@"imgIcon":@"home_05",@"type":@"推送并打开指定页面"},
        ];
    }
    return _dataArray;
}
@end

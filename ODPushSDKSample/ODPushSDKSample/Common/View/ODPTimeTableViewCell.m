//
//  ODPTimeTableViewCell.m
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/26.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODPTimeTableViewCell.h"
#import "UIColor+ODExtension.h"
#import "ODPushHeader.h"

@interface ODPTimeTableViewCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *selectedBadge;

@end

@implementation ODPTimeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.frame = CGRectMake(25 * PUBLICSCALE, 5, 100, 20);
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor colorWithRed:51 withGreen:51 withBlue:51];
    [self.contentView addSubview:self.timeLabel];
    
    self.selectedBadge = [[UIImageView alloc] init];
    self.selectedBadge.image = [UIImage imageNamed:@"push_choose"];
    self.selectedBadge.frame = CGRectMake(SCREEN_WIDTH - (25 + 12)* PUBLICSCALE - self.selectedBadge.image.size.width , (44 - self.selectedBadge.image.size.height)/2.0, self.selectedBadge.image.size.width, self.selectedBadge.image.size.height);
    [self.contentView addSubview:self.selectedBadge];
}


- (void)setTimeDic:(NSDictionary *)timeDic{
    _timeDic = timeDic;
    self.timeLabel.text = timeDic[@"text"];
    BOOL select = [timeDic[@"select"] boolValue];
    self.selectedBadge.hidden = !select;
    if (select) {
        self.timeLabel.textColor = [UIColor colorWithRed:4 withGreen:203 withBlue:148];
    }else{
         self.timeLabel.textColor = [UIColor colorWithRed:51 withGreen:51 withBlue:51];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SSSettingTableViewCell.m
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/14.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SSSettingTableViewCell.h"
#import "SSSetModel.h"
NSString * const SSSettingTableViewCellID = @"SSSettingTableViewCellID";
@interface SSSettingTableViewCell()
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UISwitch *switchView;
@property (retain, nonatomic) IBOutlet UIImageView *arrowsView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *dividerImageViewConstranit;

@end
@implementation SSSettingTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setSetModel:(SSSetModel *)setModel
{
    _setModel = setModel;
    self.titleLabel.text = setModel.title;
    switch (setModel.type) {
        case SSSetModelTypeArrows:
        {
            self.switchView.hidden = YES;
            self.arrowsView.hidden = !self.switchView.hidden;
        }
        break;
        case SSSetModelTypeSwitch:
        {
            self.switchView.hidden = NO;
            self.arrowsView.hidden = !self.switchView.hidden;
        }
        break;
        default:
            break;
    }
    self.dividerImageViewConstranit.constant = setModel.isRetract ? 15 : 0;
}


@end

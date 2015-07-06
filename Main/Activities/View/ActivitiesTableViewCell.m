//
//  ActivitiesTableViewCell.m
//  YiChe
//
//  Created by imac on 15-5-7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ActivitiesTableViewCell.h"

@implementation ActivitiesTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

-(void)setModel:(ActivitiesModel *)model{

    _model = model;
    [self setCellData];
}

- (void)setCellData{

    [_adImage setImageWithURL:[NSURL URLWithString:_model.images]];
    _adLabel.text = _model.title;
    _sourceAndBrandLabel.text = _model.sponsor;
    _timeLabel.text = [NSString stringWithFormat:@"时间：%@至%@",_model.start_data,_model.end_data];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

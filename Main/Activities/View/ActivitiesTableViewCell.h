//
//  ActivitiesTableViewCell.h
//  YiChe
//
//  Created by imac on 15-5-7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivitiesModel.h"

@interface ActivitiesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UILabel *adLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceAndBrandLabel;
@property (weak, nonatomic) IBOutlet UIImageView *joinImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic,retain) ActivitiesModel *model;
@end

//
//  VidCollectionViewCell.h
//  YiChe
//
//  Created by imac on 15-5-3.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VidCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageLink;
@property (weak, nonatomic) IBOutlet UIImageView *PlayImage;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UIImageView *TimeImage;
@property (weak, nonatomic) IBOutlet UILabel *Duration;
@property (weak, nonatomic) IBOutlet UIImageView *VideoImage;
@property (weak, nonatomic) IBOutlet UILabel *TotalVisit;

@property (nonatomic,retain) VideoModel *model;
@end

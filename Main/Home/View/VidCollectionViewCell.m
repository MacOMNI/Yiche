//
//  VidCollectionViewCell.m
//  YiChe
//
//  Created by imac on 15-5-3.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "VidCollectionViewCell.h"

@implementation VidCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    [self loadData];
}

-(void)setModel:(VideoModel *)model{

    _model = model;
    
    [self loadData];
    
}
- (void)loadData{

    NSString *str = _model.ImageLink;
    NSURL *url = [NSURL URLWithString:str];
    [_ImageLink setImageWithURL:url];
    
    [_PlayImage setImage:[UIImage imageNamed:@"ic_banner_nor_@2x.png"]];
    _PlayImage.size = CGSizeMake(10, 10);
    [_Title setText:_model.Title];
    
    [_TimeImage setImage:[UIImage imageNamed:@"newsList_click@2x.png"]];
    
    [_Duration setText:_model.Duration];
    
    [_VideoImage setImage:[UIImage imageNamed:@"newsList_play@2x.png"]];
    
    [_TotalVisit setText:[NSString stringWithFormat:@"%ld",_model.TotalVisit]];

}
@end

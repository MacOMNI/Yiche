//
//  MoreTableViewCell.m
//  YiChe
//
//  Created by imac on 15-5-7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setImagesName:(NSString *)imagesName{

    _imagesName = imagesName;
    [_tuBiao setImage:[UIImage imageNamed:imagesName]] ;
}

-(void)setLabelsName:(NSString *)labelsName{

    _labelsName = labelsName;
    _Label.text = labelsName;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  CheYouView.h
//  YiChe
//
//  Created by imac on 15-5-6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"
#import "WBImageView.h"
#import "CheyouHomeModel.h"

@interface CheYouView : UIView<CNLabelDelegate>

@property (nonatomic,strong) CNLabel*contentLabel;
@property (nonatomic,strong) WBImageView *imageView;
@property (nonatomic,strong) CheyouHomeModel *data;


@end

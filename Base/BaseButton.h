//
//  BaseButton.h
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIControl

@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UILabel *label;

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withTitle:(NSString *)title;
@end

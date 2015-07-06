//
//  BaseButton.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

-(id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withTitle:(NSString *)title{

    self = [super initWithFrame:frame];
    if (self) {
        
        //1、创建图片视图
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-20)/2, 5, 20, 20)];
        _imageView.image = [UIImage imageNamed:imageName];
        
        [self addSubview:_imageView];
        
        //2、标题
      _label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), frame.size.width, 20)];
        _label.font = [UIFont systemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = title ;
        _label.textColor = [UIColor grayColor];
        [self addSubview:_label];
    }
    
    return self;
}
@end

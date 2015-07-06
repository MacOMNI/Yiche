//
//  CheYouView.m
//  YiChe
//
//  Created by imac on 15-5-6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CheYouView.h"
#import "WeiboCellConfig.h"

@implementation CheYouView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)awakeFromNib{

    [self createView];
}

- (void)createView{

    _imageView = [[WBImageView alloc] initWithFrame:CGRectZero];
    _imageView.hidden = YES;
    _imageView.userInteractionEnabled = YES;
    
    _contentLabel = [WeiboCellConfig createLabel];
    _contentLabel.delegate = self;
    [self addSubview:_contentLabel];
    
    [self addSubview:_imageView];
    
    
}

//重新布局
- (void)resizeSubviews{

    _contentLabel.text = _data.content;
    
    CGFloat height = _contentLabel.height;
    
    
    NSArray *imageList = _data.imageList;
    if(imageList.count > 0){
    
        _imageView.hidden = NO;
//        _imageView.left = 30;
        
        _imageView.top = _contentLabel.bottom +5;
        _imageView.height = [WBImageView heightForCount:(int)imageList.count];
        
        _imageView.width = kScreenWidth;
        
        [_imageView setDataList:imageList];
        height += _imageView.height;
    }
    
    self.height = height + 20;
    
}

- (void)setData:(CheyouHomeModel *)data{

    _data = data;
    [self resizeSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

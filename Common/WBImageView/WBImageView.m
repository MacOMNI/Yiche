//
//  WBImageView.m
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

/*
 
 1.点击放大动画，在present出来的VC.view里面完成
 
 2.点击dismiss动画，在WBImageView完成
 
 
 
 
 
*/



#import "WBImageView.h"
#import "UIImageView+WebCache.h"
#import "WBImageViewItem.h"
#define kWBImageViewWH 60
#define kWBspace 10
@implementation WBImageView



-(void)setDataList:(NSArray *)dataList{
    
    _dataList= dataList;
    
//    tableView重用时，先移除原有的item
    for (UIView* view in self.subviews) {
        if (view.tag >=1000 &&view.tag<=1009) {
            
            [view removeFromSuperview];
        }
        
    }
    
    for (int i = 0; i<dataList.count; i++) {
        
//        初始化
        WBImageViewItem *imageView = [[WBImageViewItem alloc] initWithFrame:[WBImageView getFrameAtIndex:i]];
        
        
        
//        NSDictionary *dic = _dataList[i];

        //        设置图片
        [imageView setImageWithURL:[NSURL URLWithString:_dataList[i]]];
        
        imageView.dataList = _dataList;
        
        imageView.index = i;
        
        imageView.originSuperView  =self;
        
        imageView.tag = 1000+i;
        
        [self addSubview:imageView];
        
    }
    
    
}

-(WBImageViewItem*)itemAtIndex:(NSInteger)index{

   return (WBImageViewItem*)[self viewWithTag:index+1000];
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}
//返回图片的frame 根据图片的index
+(CGRect)getFrameAtIndex:(NSInteger)index{
    
    
    CGFloat x = index%3*(kWBImageViewWH+kWBspace);
    CGFloat y = index/3*(kWBImageViewWH+kWBspace);
    
    return CGRectMake(x, y, kWBImageViewWH, kWBImageViewWH);
    
}

+(CGFloat) heightForCount:(int)count{
    return ((count -1)/3+1)*(kWBImageViewWH+kWBspace);
}

@end

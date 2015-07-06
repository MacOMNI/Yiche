//
//  WBImageViewItem.m
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "WBImageViewItem.h"
#import "WBImageViewController.h"
#import "UIView+UIViewController.h"
@implementation WBImageViewItem

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        布局方式
        self.contentMode = UIViewContentModeScaleAspectFit;
//        打开响应
        self.userInteractionEnabled = YES;
//        添加tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct)];
        [self addGestureRecognizer:tap];
        
//        创建时 保存frame
        _originFrame = frame;
        
    }
    return self;
}

//tap 触发的方法
-(void)tapAct{
    
    NSSet *touch = nil;
    UIEvent *event = nil;
    
    //将响应传给父视图作为响应者，然后一级一级向下传(目的是使当前cell在其他cell的前面)
    [self.nextResponder touchesBegan:touch withEvent:event];
    
    
    WBImageViewController *controller = [[WBImageViewController alloc] init];

    controller.dataList = self.dataList;
    
    controller.currentIndex = self.index;
    controller.currentItem = self;

    [self.viewController presentViewController:controller animated:NO completion:nil];
    
}


//计算出item相对于window的frame
-(CGRect)getNewFrameAtWindow:(CGRect)originFrame{
    
    
    //    1.原有坐标系  2.原有坐标  3.新坐标系
    
    return [self.superview convertRect:self.frame toView:self.window];
    
    
}

//点击时间需要传递到cell中
- (void)sendTouchEventToCell{

    NSSet *touch = nil;
    UIEvent *event = nil;
    
    UIResponder *next = self.nextResponder;
    
    while(![next isKindOfClass:[UITableViewCell class]]){
    
        next = next.nextResponder;
        
        //避免死循环  添加终止条件
        if([next isKindOfClass:[UIViewController class]]){
        
            return;
        }
    }
    [next touchesBegan:touch withEvent:event];
}



@end

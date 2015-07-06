//
//  WBImageViewController.h
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBImageViewItem.h"

@interface WBImageViewController : UIViewController<UIScrollViewDelegate>
//    需要数据进行展示
@property (nonatomic,copy) NSArray *dataList;

//当前选中第几个
@property (assign) NSInteger currentIndex;

//当前的item
@property (nonatomic,strong) WBImageViewItem *currentItem;

//展示图片用的scrollView （CollectionView也可以）
@property(nonatomic,strong) UIScrollView* scrollView;

@end

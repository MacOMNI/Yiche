//
//  VedioViewController.h
//  YiChe
//
//  Created by Xin the Great on 15-4-30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface VedioViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,retain)NSMutableArray *videoList; //存放视频数据


@end

//
//  WBImageViewController.m
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "WBImageViewController.h"
#import "UIImageView+WebCache.h"
@interface WBImageViewController ()

@end

@implementation WBImageViewController

//UIImageView 点击 dismiss
-(void)dismiss{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
//    根据item 获取WBImageView
    WBImageView *wbImageView = self.currentItem.originSuperView;
    
//    根据index 获取item
    WBImageViewItem*item = [wbImageView itemAtIndex:self.currentIndex];
    
//    把该item 移动到WBImageView的最前端
    [wbImageView bringSubviewToFront:item];
    
//    转换坐标
   CGPoint point = [self.view convertPoint:CGPointZero toView:wbImageView];
    
    
    item.frame = CGRectMake(point.x, point.y, self.view.bounds.size.width, self.view.bounds.size.height);
    
//    缩小的动画
    [UIView animateWithDuration:.35 animations:^{
       	
        item.frame = item.originFrame;
        
    }];
    
    
    
    
    
    
}

-(void)loadScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.scrollView.delegate = self;
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    _scrollView.contentSize = CGSizeMake((_dataList.count)*width,height);
    
    
    
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;

    
//    滚动到 对应的位置
    [_scrollView scrollRectToVisible:CGRectMake(self.currentIndex*width, 0, width, height) animated:NO];
    

    int i=0;
    for (NSDictionary *dic in self.dataList) {
        NSString*urlstr    =dic[@"thumbnail_pic"];
        
        NSString*bigurlstr    = [urlstr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];

        
        NSURL *url = [NSURL URLWithString:bigurlstr];
        
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        
        imagev.userInteractionEnabled = YES;
        imagev.contentMode = UIViewContentModeScaleAspectFit;
        
        [imagev setImageWithURL:url];
        
        [self.scrollView addSubview:imagev];
        
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        
        [imagev addGestureRecognizer:tapGes];

        
        i++;
    }
    [self.view addSubview:self.scrollView];
    self.scrollView.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadScrollView];
    
    
//    把点击的item 移动到VC的View上，并且保证相对于屏幕位置不变
    self.currentItem.frame =   [self.currentItem getNewFrameAtWindow:self.currentItem.frame];
    [self.view addSubview:self.currentItem];
    
    
}





-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

//    开始动画
    [self startZoomIn];
}


//动画
-(void)startZoomIn{

    [UIView animateWithDuration:.35 animations:^{
//        把item的frame 放大
        self.currentItem.frame = self.view.bounds;
        
    } completion:^(BOOL finished) {
        

        //        scroll 显示
        self.scrollView.hidden = NO;
        
//        把item 恢复原状态
        self.currentItem.frame = self.currentItem.originFrame;
        [self.currentItem.originSuperView addSubview:self.currentItem];
        
    }];
    


    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    self.currentIndex = scrollView.contentOffset.x/375.0f;
    
    
    
}



@end

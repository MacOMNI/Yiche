//
//  CustomTabBarController.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "RidersViewController.h"
#import "ChooseViewController.h"
#import "ActivitiesViewController.h"
#import "MoreViewController.h"
#import "MainViewController.h"
#import "ActViewController.h"

#import "BaseButton.h"
#import "Common.h"
@interface CustomTabBarController ()

{
    NSArray *viewCtrls;    //存放视图数组
    UIImageView *selectImage;//选中视图
    NSArray *btnSelectedNames ; //按钮图片名称
    int currentIndex; //记录上一个tabbar button的数值
}
@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载子控制器
    [self _loadSubViewCtrl];
    
    //移除系统tabbar按钮
    [self _removeSystemBarbtn];
    
    //3、添加自定义按钮
    [self _creatTabbarBtn];}

- (void)_creatTabbarBtn{

    //设置tabbar背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTabbarHeight)];
    [self.tabBar addSubview:imageView];
    
    //创建选中视图
    //1、创建选中视图
    selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    selectImage.image = [UIImage imageNamed:@"tabbar_0_H@2x.png"];
    [self.tabBar addSubview:selectImage];
    
    //创建数组
    NSArray *titles = @[@"头条",@"车友",@"选车",@"活动",@"更多"];
    
    //按钮图片名称
    NSArray *imageNames = @[@"tabbar_0_N@2x.png",
                            @"tabbar_1_N@2x.png",
                            @"tabbar_2_N@2x.png",
                            @"tabbar_3_N@2x.png",
                            @"tabbar_4_N@2x.png" ];
    
    
        for (int i = 0; i < titles.count; i++) {
    
            //按钮标题
            NSString *title = titles[i];
        
            //按钮图片
            NSString *imageName = imageNames[i];
            
            //子类化UIControl 创建自定义按钮
            BaseButton *btn =[[BaseButton alloc]initWithFrame:CGRectMake(kScreenWidth/titles.count*i, 0, kScreenWidth/titles.count, kTabbarHeight) withImageName:imageName withTitle:title];

            
            //给自定义按钮添加点击事件，切换子控制器
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

            btn.tag = i+100;

            [self.tabBar addSubview:btn];
            
            //当页面第一次显示时，使选中视图在第一个按钮的位置
            if (i ==0){
                
            selectImage.frame = CGRectMake((btn.frame.size.width-20)/2+(kScreenWidth/5*i), 5, 20, 20);
            btn.label.textColor = [UIColor colorWithRed:38.0/255.0 green:109.0/255.0 blue:226.0/255.0 alpha:1];
    
        }
    }
}

//按钮点击方法
- (void)btnAction:(BaseButton *)btn{
    
    
    int i = (int )btn.tag-100;
    
    if (currentIndex != i ) {
        
        BaseButton *button = (BaseButton *)[self.view viewWithTag:currentIndex+100];
        
//        button.label.textColor = [UIColor grayColor];
    }

    btnSelectedNames = @[@"tabbar_0_H@2x.png",
                            @"tabbar_1_H@2x.png",
                            @"tabbar_2_H@2x.png",
                            @"tabbar_3_H@2x.png",
                            @"tabbar_4_H@2x.png" ];
    [selectImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%ld_H@2x.png",btn.tag-100]]];
    
    selectImage.frame = CGRectMake((btn.frame.size.width-20)/2+(kScreenWidth/5*i), 5, 20, 20);
    
    btn.label.textColor = [UIColor colorWithRed:38.0/255.0 green:109.0/255.0 blue:226.0/255.0 alpha:1];
    //切换子控制器
    self.selectedIndex = btn.tag-100;
    currentIndex = i;
    
    
}

- (void)_removeSystemBarbtn{
    
    Class class =  NSClassFromString(@"UITabBarButton");
    
    for (UIView *view in self.tabBar.subviews){
        
        //如果view是由UITabBarButton类创建的对象，则将其移除
        if ([view isKindOfClass:class]){
            
            [view removeFromSuperview];
        }
    }
}
- (void)_loadSubViewCtrl{

    //创建子控制器（三级）
    MainViewController *homeCtrl = [[MainViewController alloc] init];
    RidersViewController *ridersCtrl = [[RidersViewController alloc] init];
    ChooseViewController *chooseCtrl = [[ChooseViewController alloc] init];
    ActViewController *activitiesCtrl = [[ActViewController alloc] init];
    MoreViewController *moreCtrl = [[MoreViewController alloc] init];
    
    viewCtrls = @[homeCtrl,ridersCtrl,chooseCtrl,activitiesCtrl,moreCtrl];
    
    //将导航控制器交给tabbarController
    self.viewControllers = viewCtrls;
    
}

@end

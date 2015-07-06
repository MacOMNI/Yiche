//
//  NewCarViewController.m
//  YiChe
//
//  Created by Xin the Great on 15-4-30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "NewCarViewController.h"

@interface NewCarViewController ()

@end

@implementation NewCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//加载新闻数据
- (void)_loadNewsListData{
    
    NSString *url = @"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=3&serialid=&pageindex=1&pagesize=20";
    
    [NetworkCore getNewsList:url succeed:^(id responseObj) {
        
        [super getJson:responseObj];
        // 重新加载数据
        
        [super reloadTableView];
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  AllVideosViewController.m
//  YiChe
//
//  Created by imac on 15-5-4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AllVideosViewController.h"

@interface AllVideosViewController ()

@end

@implementation AllVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//加载新闻数据
- (void)_loadNewsListData{
    
    NSString *url = @"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=2&serialid=&pageindex=1&pagesize=20";
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

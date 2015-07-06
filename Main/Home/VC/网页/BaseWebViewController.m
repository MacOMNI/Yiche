//
//  BaseWebViewController.m
//  YiChe
//
//  Created by Xin the Great on 15-4-29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //网页自适应
    _webView.scalesPageToFit = YES;
    
    //加载网页
    [self loadRequest];
}

- (void)loadRequest{
    
    
    NSURL *url = [NSURL URLWithString:_newsModel.filePath];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
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

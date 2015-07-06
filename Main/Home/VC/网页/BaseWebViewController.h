//
//  BaseWebViewController.h
//  YiChe
//
//  Created by Xin the Great on 15-4-29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface BaseWebViewController : UINavigationController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong) NewsModel *newsModel;

@end

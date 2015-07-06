//
//  WebViewController.h
//  YiChe
//
//  Created by Xin the Great on 15-4-29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsModel.h"
#import "VideoModel.h"
@interface WebViewController : UIViewController<UITextViewDelegate>
{

  //记录当前 index
    int currentIndex;
    
  //保存 URL
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *webTitle;
@property (weak, nonatomic) IBOutlet UIButton *navBackBtn;

- (IBAction)backButton:(UIButton *)sender;

//@property (nonatomic,strong) NewsModel *newsModel;

//@property (nonatomic,strong) VideoModel *videoModel;

@property (nonatomic, copy) NSString *itemType;

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, assign) NSInteger commentCount;


@end

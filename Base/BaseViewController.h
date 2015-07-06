//
//  BaseViewController.h
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic,retain)NSMutableArray *newsLists;//存储新闻model


- (void)reloadTableView;

- (void)getJson:(NSDictionary *)dic;

@end

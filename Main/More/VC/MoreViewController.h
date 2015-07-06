//
//  MoreViewController.h
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_headerBackgroundView;//背景图
    UIView *_tableHeaderView;//tableView的头视图
    UITableView *_tableView;//表示图
}
@end

//
//  RidersViewController.h
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RidersViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *riderList;

@end

//
//  MoreTableViewCell.h
//  YiChe
//
//  Created by imac on 15-5-7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tuBiao;
@property (weak, nonatomic) IBOutlet UILabel *Label;

@property (nonatomic,copy) NSString *imagesName;
@property (nonatomic,copy) NSString *labelsName;

@end

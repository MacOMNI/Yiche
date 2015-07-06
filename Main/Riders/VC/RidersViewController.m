//
//  RidersViewController.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RidersViewController.h"
#import "RidersTableViewCell.h"
#import "CheyouHomeModel.h"
#import "WeiboCellConfig.h"



@interface RidersViewController ()

@end

static NSString *identifier = @"RidersTableViewCell";

@implementation RidersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

//加载新闻数据
- (void)_loadNewsListData{
    
    NSString *url = @"http://api.ycapp.yiche.com/appforum/cheyouhome/";
    
    [NetworkCore getNewsList:url succeed:^(id responseObj) {
        
        [self getJson:responseObj];
        // 重新加载数据
        
        [super reloadTableView];
        
    }];
}

- (void)getJson:(NSDictionary *)dic{

    _riderList = [[NSMutableArray alloc]init];
    
    NSArray *dataArray = [dic objectForKey:@"data"];
    for (NSDictionary *dicc in dataArray) {
        
        CheyouHomeModel *cheyouModel = [[CheyouHomeModel alloc]init];
        cheyouModel.topicId = [[dicc objectForKey:@"topicId"]integerValue];
        cheyouModel.userId = [[dicc objectForKey:@"userId"]integerValue];
        cheyouModel.userName = [dicc objectForKey:@"userName"];
        cheyouModel.userAvatar =  [dicc objectForKey:@"userAvatar"];
        cheyouModel.publishTime =  [dicc objectForKey:@"publishTime"];
        cheyouModel.forumName =  [dicc objectForKey:@"forumName"];
        cheyouModel.content =  [dicc objectForKey:@"content"];
        cheyouModel.imageList =  [dicc objectForKey:@"imageList"];
        cheyouModel.agreeCount =  [[dicc objectForKey:@"agreeCount"]integerValue];
        cheyouModel.agree =  [dicc objectForKey:@"agree"];
        cheyouModel.commentCount =  [[dicc objectForKey:@"commentCount"]integerValue];
        cheyouModel.comment =  [dicc objectForKey:@"comment"];
        cheyouModel.location = [dicc objectForKey:@"location"];
        [_riderList addObject:cheyouModel];
    }
}


#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _riderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //1、重用  2、初始化  3、设置数据
    RidersTableViewCell *cell = (RidersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
    
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RidersTableViewCell"
                                             owner:nil options:nil]lastObject];
        
    //取消点击效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CheyouHomeModel *ridersModel = _riderList[indexPath.row];
    cell.model = ridersModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //如果model中 有车友cell的高度。不需要重新计算，如果没有，计算一次，并且保存到model中
    CheyouHomeModel *model = _riderList[indexPath.row];
    if (!model.cheyouHeight) {
        
        model.cheyouHeight = [WeiboCellConfig getWeiboCellHeight:model];
        
    }
    return model.cheyouHeight + 100;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    
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

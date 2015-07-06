//
//  BaseViewController.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

#import "NewsModel.h"
#import "WebViewController.h"
#import "BaseWebViewController.h"
#import "HomeListCellTableViewCell.h"

@interface BaseViewController ()
{
    UITableView *_tableView; //表视图
    
}
@end
static NSString *indenty = @"HomeListCellTableViewCell";

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //把所有的视图背景变为黑色，是5个视图共有的父类
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_zanwu_kb.png"]];
//    self.view.backgroundColor = [UIColor]
    [self _createHomeList];
    [self _loadNewsListData];
}


//加载新闻数据
- (void)_loadNewsListData{
    
    [NetworkCore getNewsLine:^(id responseObj) {
        
        [self getJson:responseObj];
        
        // 重新加载数据
        [_tableView reloadData];
    }];
    
    
    
}

- (void)reloadTableView
{
    [_tableView reloadData];
}

- (void)getJson:(NSDictionary *)dic{
    
    
    NSDictionary *dataJson = [dic objectForKey:@"data"];
    NSArray *newslist = [dataJson objectForKey:@"list"];
    
    //开辟数组空间
    _newsLists = [[NSMutableArray alloc]init];
    
    
    for(NSDictionary *dicc in newslist){
        
        //给model赋值
        NewsModel *newsModel1 = [[NewsModel alloc]init];
        newsModel1.newsId = [[dicc objectForKey:@"newsId"]integerValue];
        newsModel1.picCover = [dicc objectForKey:@"picCover"];
        newsModel1.filePath = [dicc objectForKey:@"filePath"];
        newsModel1.title = [dicc objectForKey:@"title"];
        newsModel1.src = [dicc objectForKey:@"src"];
        newsModel1.commentCount = [[dicc objectForKey:@"commentCount"]integerValue];
        newsModel1.type = [[dicc objectForKey:@"type"]integerValue];
        newsModel1.itemType = [dicc objectForKey:@"itemType"];
        
        if([newsModel1.filePath  isEqual: @""]){
            
            newsModel1.filePath = [NSString stringWithFormat:@"http://h5.ycapp.yiche.com/news/%ld.html?plat=2",newsModel1.newsId];
            
        }
        //将model添加到数组中
        [_newsLists addObject:newsModel1];
        
    }
    
}

- (void)_createHomeList{
    
    //创建表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
    
    
}

#pragma delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return 20;
    return _newsLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeListCellTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:indenty];
    
    if(cell == nil){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:self options:nil]lastObject];
    }
    NewsModel *news = [_newsLists objectAtIndex:indexPath.row];
    
    cell.news = news;
    
    return cell;
}

//点击cell调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    //    BaseWebViewController *vc = [[BaseWebViewController alloc]init];
//    vc.newsModel = _newsLists[indexPath.row];
    
    NewsModel *model = _newsLists[indexPath.row];
    
    vc.itemType = model.itemType;
    vc.filePath = model.filePath;
    vc.commentCount = model.commentCount;
    
    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
}


@end

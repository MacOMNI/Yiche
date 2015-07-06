//
//  HomeViewController.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListCellTableViewCell.h"
#import "NewsModel.h"
#import "WebViewController.h"
#import "BaseWebViewController.h"

@interface HomeViewController ()

@end

static NSString *indenty = @"HomeListCellTableViewCell";

@implementation HomeViewController
{
    UITableView *_tableView; //表视图
    UIScrollView *headerView;  //头视图
    UIPageControl *pageCtrl;   //分页视图
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //创建视图
    [self _createHomeList];
    
    //加载数据
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
    [self creatHeaderView];

}

- (void)creatHeaderView{

    //创建滚动头视图
    headerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    headerView.backgroundColor = [UIColor grayColor];
    headerView.tag = 100;
    headerView.contentSize = CGSizeMake(kScreenWidth+300, 150);
    
    //滚动到开始,末尾时,是否显示反弹效果
    headerView.bounces = YES;
    
    //分页效果
    headerView.pagingEnabled = YES;
    
    
    
    //创建子视图
    for (int i = 0; i<5; i++) {
    
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, 150)];
        
        //通过下标取得model
        NewsModel *news = [_newsLists objectAtIndex:i];
        NSString *str = news.picCover;
        NSURL *url = [NSURL URLWithString:str];
        [imageView setImageWithURL:url];
        
        //创建UIView
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 130, kScreenWidth, 20)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = .5;
        [imageView addSubview:view];
        
        
        //在视图上添加label
        UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        imageLabel.text = news.title;
        imageLabel.font = [UIFont systemFontOfSize:12];
        imageLabel.textColor = [UIColor whiteColor];
        imageLabel.alpha = 1;
        imageLabel.textAlignment = NSTextAlignmentLeft;
        imageLabel.highlighted = YES;
        [view addSubview:imageLabel];
        
        [headerView addSubview:imageView];
    
    }
    //设置内容尺寸（出现滑动效果）
    headerView.contentSize = CGSizeMake(kScreenWidth * 5, 150);
    headerView.delegate = self;
    
    //创建分页视图
    pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth-80,130 ,50, 20)];
    
    pageCtrl.numberOfPages = 5;
    
    [_tableView addSubview:pageCtrl];

    _tableView.tableHeaderView = headerView;
    
    
    //创建完头视图后，删除新闻数据，以免重复
    for (int i = 0; i<5; i++) {
        
        [_newsLists removeObjectAtIndex:0];
    }
}

//分页视图滑动时自动调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (headerView.tag == 100) {
        
        NSInteger index = headerView.contentOffset.x/kScreenWidth;
        pageCtrl.currentPage = index;
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

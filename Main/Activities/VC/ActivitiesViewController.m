//
//  ActivitiesViewController.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "ActivitiesTableViewCell.h"
#import "ActivitiesModel.h"
#import "WebViewController.h"

@interface ActivitiesViewController ()
{
    UITableView *_tableView;
}
@end

static NSString *identifier = @"ActivitiesTableViewCell";

@implementation ActivitiesViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    
//    UINavigationBar.
//    self.title = @"推荐";
//    self.navigationItem.title = @"推荐";
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 30);
    [button setTitle:@"按钮" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(titleViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;

    
    [super viewDidLoad];

    //创建表示图
    [self createTableView];
    
    //加载数据
    [self loadAcListData];
}

- (void)loadAcListData{

    NSString *url = @"http://api.hd.bitauto.com/baojia/?appid=540ff6b5db742&appkey=b5de92a2c74ade114c08e6ee63f01210&city_id=2101&device_id=5A0264B528C4BBF529EC36772E4554A0&device_type=2&page_num=1&result_count=20&token=d5bf8d88e69bec33ac5247f7469e457e";
    
    [NetworkCore getAdsList:url succeed:^(id responseObj) {
        
        [self getJson:responseObj];

        [_tableView reloadData];
    }];
    
}

- (void)getJson:(NSDictionary *)dic{
    
    NSDictionary *dataJson = [dic objectForKey:@"data"];
    NSArray *items = [dataJson objectForKey:@"items" ];
    _activitiesArr = [[NSMutableArray alloc]init];
    
    for(NSDictionary *dicc in items){
        
    ActivitiesModel *model = [[ActivitiesModel alloc]init];
        
        model.title = [dicc objectForKey:@"title"];
        model.images = [dicc objectForKey:@"images"];
        model.sponsor = [dicc objectForKey:@"sponsor"];
        model.start_data = [dicc objectForKey:@"start_date"];
        model.end_data = [dicc objectForKey:@"end_date"];
        model.url = [dicc objectForKey:@"url"];
        [_activitiesArr addObject:model];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //1、重用  2、初始化  3、设置数据
    ActivitiesTableViewCell *cell = (ActivitiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivitiesTableViewCell"
                                              owner:nil options:nil]lastObject];
        
        //取消点击效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ActivitiesModel *activitiesModel = _activitiesArr[indexPath.row];
    cell.model = activitiesModel;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 300;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *vc = [[WebViewController alloc]init];
    
    //    BaseWebViewController *vc = [[BaseWebViewController alloc]init];
    //    vc.newsModel = _newsLists[indexPath.row];
    
    ActivitiesModel *model = _activitiesArr[indexPath.row];
    vc.itemType = @"ss";
    vc.filePath = model.url;
    vc.commentCount = 0;
    
    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];

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

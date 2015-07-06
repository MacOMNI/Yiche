//
//  MoreViewController.m
//  YiChe
//
//  Created by imac on 15-4-25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"

@interface MoreViewController ()
{
    NSArray *_imagesArr;
    NSArray *_labelArr;
}
@end

static NSString *identy = @"MoreTableViewCell";

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imagesArr = @[@"ic_xiaoxi@2x.png",@"ic_shezhi@2x.png",@"ic_yijianfankui@2x.png",@"ic_pingfen@2x.png",@"ic_gongju@2x.png"];
    
    _labelArr = @[@"消息",@"设置",@"意见反馈",@"评分",@"工具"];
    [self loadTableView];
    [self loadTableHeaderView];
    [self loadBgView];
}

- (void)loadTableView{
    
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
//    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (void)loadBgView{

    _headerBackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    _headerBackgroundView.image = [UIImage imageNamed:@"mine_bg_640@2x.png"];
    
    _headerBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    
//    [self.view addSubview:_headerBackgroundView];
//    [_tableView addSubview:_headerBackgroundView];
    
    [_tableView insertSubview:_headerBackgroundView belowSubview:_tableHeaderView];
    
//    [_tableView insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>]
//    [self.view insertSubview:_headerBackgroundView belowSubview:_tableView];
    
//    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
//    [_tableView sendSubviewToBack:_headerBackgroundView];

}

- (void)loadTableHeaderView{

    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    _tableView.tableHeaderView = _tableHeaderView;
    
//    [_tableHeaderView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-40)/2,25 , 40, 10)];
    label.textColor = [UIColor whiteColor];
    label.text = @"登录";
    [_tableHeaderView addSubview:label];
    
    NSArray *btnNor = @[@"btn_weixin_nor@2x.png",@"btn_qq_nor@2x.png",@"btn_weibo_nor@2x.png",@"btn_yiche_nor@2x.png"];
    NSArray *btnPress = @[@"btn_weixin_press@2x.png",@"btn_qq_press@2x.png",@"btn_weibo_press@2x.png",@"btn_yiche_press@2x.png"];
    NSArray *btnName = @[@"微信",@"QQ",@"微博",@"易车"];
    for(int i = 0;i < 4;i++){
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake((kScreenWidth/4)*i+15, 80, 60, 60);
        [btn setImage:[UIImage imageNamed:btnNor[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnPress[i]] forState:UIControlStateHighlighted];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
//        label.frame = btn.frame;
        label.center = btn.center;
        label.top = btn.bottom + 10;
        label.font = [UIFont systemFontOfSize:15];
        label.text = btnName[i];
        label.textColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:label];
        
        [_tableHeaderView addSubview:btn];
        
        

        
    }
}

#pragma delegata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section == 1)
        return 3;
    else
        return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MoreTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identy];
    
    if(cell == nil){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:identy owner:self options:nil]lastObject];
    }
    
    if(indexPath.section == 0)
    {
        cell.imagesName = _imagesArr[indexPath.row];
        cell.labelsName = _labelArr[indexPath.row];
    }
    else if (indexPath.section == 1){
    
        cell.imagesName = _imagesArr[indexPath.row + indexPath.section];
        cell.labelsName = _labelArr[indexPath.row + indexPath.section];
    }
    else{
        cell.imagesName = _imagesArr[4];
        cell.labelsName = _labelArr[4];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if(section == 2)
    {
        UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        views.backgroundColor = [UIColor whiteColor];
        
        NSArray *btnNor = @[@"mine_toolbox_forum_N@2x.png",@"mine_toolbox_pk_N@2x.png",@"mine_toolbox_calculator_N@2x.png",@"mine_toolbox_calculator_N@2x.png"];
        NSArray *btnPress = @[@"mine_toolbox_forum_H@2x.png",@"mine_toolbox_pk_H@2x.png",@"mine_toolbox_calculator_H@2x.png",@"mine_toolbox_calculator_H@2x.png"];
        NSArray *btnName = @[@"易车论坛",@"车型对比",@"购车计算器",@"易车特卖"];

        
        
        for(int i = 0;i < 4;i++){
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame = CGRectMake((kScreenWidth/4)*i+15, 10, 60, 60);
            [btn setImage:[UIImage imageNamed:btnNor[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:btnPress[i]] forState:UIControlStateHighlighted];
            
            [views addSubview:btn];
            
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake((kScreenWidth/4)*i+20, 30, 100, 100)];
            //        label.frame = btn.frame;
//            label.center = btn.center;
//            label.top = btn.bottom + 10;
            label.font = [UIFont systemFontOfSize:12];
            label.text = btnName[i];
            label.textColor = [UIColor blueColor];
            [views addSubview:label];

            
        }

        
        return views;
    }
    else if (section == 0)
    {
        UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        views.backgroundColor = [UIColor redColor];
        
        
        
        return views;
    }
    
    return nil;
}


//尾视图高图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 2)
        return 100;
    else
        return 1;
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

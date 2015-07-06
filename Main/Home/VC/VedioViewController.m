//
//  VedioViewController.m
//  YiChe
//
//  Created by Xin the Great on 15-4-30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "VedioViewController.h"
#import "VidCollectionViewCell.h"
#import "VideoModel.h"
#import "WebViewController.h"
#import "AllVideosViewController.h"

@interface VedioViewController ()
{
    UICollectionView *_videoCollectionView;
    NSMutableDictionary *_headerDic;
}
@end

static NSString *identy = @"VidCollectionViewCell";
static NSString *headerIndenty = @"headView";

@implementation VedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createVideoSubsView];
    
    [self loadData];
}

//
- (void)loadData{
    
    NSString *url = @"http://api.ycapp.yiche.com/video/getvideolist?categoryid=-1";
    
    [NetworkCore getNewsList:url succeed:^(id responseObj) {
        [self getJson:responseObj];
        [_videoCollectionView reloadData];
    }];
    
}

- (void)getJson:(NSDictionary *)dic{
    
    
    NSDictionary *dataJson = [dic objectForKey:@"data"];
    NSArray *newslist = [dataJson objectForKey:@"list"];
    
    //开辟数组空间
    _videoList = [[NSMutableArray alloc]init];
    
    _headerDic = [[NSMutableDictionary alloc] init];
    
//    _subArr = [NSMutableArray array];
    
    for(NSDictionary *dicc in newslist){
        
        //给model赋值
        VideoModel *videoModel = [[VideoModel alloc]init];
        
        videoModel.VideoId = [[dicc objectForKey:@"VideoId"]integerValue];
        videoModel.Title = [dicc objectForKey:@"Title"];
        videoModel.PlayLink = [dicc objectForKey:@"PlayLink"];
        videoModel.ImageLink = [dicc objectForKey:@"ImageLink"];
        videoModel.TotalVisit = [[dicc objectForKey:@"TotalVisit"]integerValue];
        videoModel.commentCount = [[dicc objectForKey:@"commentCount"]integerValue];
        videoModel.Duration = [dicc objectForKey:@"Duration"];
        videoModel.CategpryName = [dicc objectForKey:@"CategoryName"];
        videoModel.CategoryId = [dicc objectForKey:@"CategoryId"];
        
        [_videoList addObject:videoModel];
        [_headerDic setObject:videoModel
                       forKey:videoModel.CategpryName];
    }
    
    NSArray *keys = [_headerDic allKeys];
    
    for (int i = 0; i < keys.count; i++) {
        
#warning ----没写完！
        
        NSString *key = keys[i];
        
        
        NSArray *subArr = [_headerDic objectForKey:key];
        
//        [_videoList addObject:subArr];

        
    }
}


//创建视图
- (void)createVideoSubsView{

    UICollectionViewFlowLayout *videoLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置单元格之间水平方向的最小间隙
    videoLayout.minimumInteritemSpacing = 10;

    videoLayout.minimumLineSpacing = 0;
    
    videoLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    videoLayout.itemSize = CGSizeMake((kScreenWidth - 40)/2, 150);
    
    videoLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 44);
    
    _videoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:videoLayout];
    
    _videoCollectionView.backgroundColor = [UIColor whiteColor];
    _videoCollectionView.delegate = self;
    _videoCollectionView.dataSource = self;
    
    [self.view addSubview:_videoCollectionView];
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"VidCollectionViewCell" bundle:[NSBundle mainBundle]];
    [_videoCollectionView registerNib:nib forCellWithReuseIdentifier:identy];
    
    //注册组的头部视图 UICollectionElementKindSectionHeader
    [_videoCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIndenty];

}

//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    NSArray *keys = [_headerDic allKeys];
    return keys.count;
//    return _videoList.count;
    
}


//每个组中元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    NSArray *keys = _videoList[section];
    return 2;
//    return keys.count;
}


#pragma mark

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //TopMovieCell子类化系统提供的UICollectionViewCell
   VidCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identy  forIndexPath:indexPath];
    
    
//    NSArray *sub = [_videoList objectAtIndex:indexPath.section];
    
    VideoModel *video = [_videoList objectAtIndex:indexPath.row+(indexPath.section *2)];
    cell.model = video;
    return cell;
    
}
//调整单元格与屏幕边缘的间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

// 组的头视图的创建
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIndenty forIndexPath:indexPath];
//    view.backgroundColor = [UIColor redColor];
    
    NSArray *keys = [_headerDic allKeys];
    
    UILabel *label = [[UILabel alloc ] initWithFrame:CGRectMake(10, 5, 100, 20)];
    label.text = keys[indexPath.section];
    [view addSubview:label];
    
//    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    allBtn setTitle:@"全部" forState:<#(UIControlState)#>
    
    UIControl *viewClick = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    [viewClick addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    viewClick.tag = indexPath.row+(indexPath.section *2) +400;
    
    [view addSubview:viewClick];
    
    return view;
    
}

- (void)headerClick:(UIControl *)view
{
    AllVideosViewController *vc = [[AllVideosViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController *vc = [[WebViewController alloc]init];
    
//    vc.newsModel = _videoList[indexPath.row];
    
    VideoModel *model = _videoList[indexPath.row+(indexPath.section *2)];
    
    vc.itemType = @"news";
    vc.filePath = model.PlayLink;
    vc.commentCount = model.commentCount;
    
    vc.hidesBottomBarWhenPushed = YES;
    
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

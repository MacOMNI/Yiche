//
//  MainViewController.m
//  YiChe
//
//  Created by Xin the Great on 15-4-30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "VedioViewController.h"
#import "NewCarViewController.h"
#import "TestViewController.h"
#import "GuideViewController.h"

@interface MainViewController () <ViewPagerDataSource, ViewPagerDelegate>
{

    NSArray *_subViews;
    NSArray *_subNames;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    
    self.dataSource = self;
    self.delegate = self;
    
    [self _createSubViews];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    [super viewDidLoad];
    
    
    
}

//创建控制器
- (void)_createSubViews
{
    
    _subViews = [[NSArray alloc] init];
    _subNames = [[NSArray alloc] init];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    VedioViewController *vedioVC = [[VedioViewController alloc] init];
    NewCarViewController *newCarVC = [[NewCarViewController alloc] init];
    TestViewController *testVC = [[TestViewController alloc] init];
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    
    _subViews = @[homeVC, vedioVC, newCarVC, testVC, guideVC];
    _subNames = @[@"要闻", @"视频", @"新车", @"测评", @"导购"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDelegate

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    return _subViews.count;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    label.text = _subNames[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    
    return label;
    
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    return _subViews[index];
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor clearColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

@end

//
//  WebViewController.m
//  YiChe
//
//  Created by Xin the Great on 15-4-29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WebViewController.h"
#import "common.h"
@interface WebViewController ()
{
    UIView *_textView;//弹出的视图
    UITextView *_textfield;//弹出的输入框
    UILabel *_textCount; //字数label
    UIButton *_sendButton; //发送button
    UIControl *_maskView;//笼罩视图
    
}
@end

@implementation WebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoard:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

//键盘隐藏调用
- (void)keyBoardHide{

    _maskView.hidden = YES;
    
    [_textfield resignFirstResponder];
    
    [UIView animateWithDuration:.5 animations:^{
     
        _textView.frame = CGRectMake(0, kScreenHeight+200, kScreenWidth, 200);

        
    }];

}

//键盘显示调用
- (void)keyBoard:(NSNotification *)noti{

    [_textfield becomeFirstResponder];
    
    _maskView.hidden = NO;
    
    //通过字典获得键盘的高度
    NSValue *frameValue = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [frameValue CGRectValue];
    
    CGFloat height = rect.size.height;
    
    //通过字典 获取到键盘的显示时 上弹动画的时间
    NSNumber *number = [noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[number integerValue] animations:^{
        
        _textView.frame = CGRectMake(0, kScreenHeight-height-200, kScreenWidth, 200) ;
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //网页自适应
    _webView.scalesPageToFit = YES;
    
    //加载网页
    [self loadRequest];
    
    //判段 navigationBar 中间是否有item,添加详情标题
    [self addDetailItem];
    
    
}

//创建普通新闻视图
- (void)createBottomView{

    //创建底部视图
    UIToolbar *bottomView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 600, kScreenWidth, kNavgationHeight)];
    bottomView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    bottomView.bottom = kScreenHeight;
    [self.view addSubview:bottomView];
    
    //创建底部 bottomField
    UITextField *bottomField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-80, kNavgationHeight-20)];
    
    //设置输入框样式
    bottomField.borderStyle = UITextBorderStyleRoundedRect;
    
    //文字左对齐
    bottomField.textAlignment = NSTextAlignmentLeft;
    
    //输入框为空的时候提示文本
    bottomField.placeholder = @"我要说两句...";
    [bottomView addSubview:bottomField];
    
    //创建底部 评论label
    UILabel *commentCount = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-60, 10, kScreenWidth-10-80-10, kNavgationHeight-20)];
    commentCount.text = [NSString stringWithFormat:@"%ld",_commentCount];
    commentCount.textColor = [UIColor blackColor];
    commentCount.font = [UIFont systemFontOfSize:14];
    commentCount.userInteractionEnabled = YES;
    [bottomView addSubview:commentCount];
    
    //创建底部按钮
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(5, 3, 45, 20);
    [bottomBtn setImage:[UIImage imageNamed:@"ic_xinxi_nor@2x.png"] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [commentCount addSubview:bottomBtn];
    
    
    //创建弹出的 View
    _textView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight+200, kScreenWidth, 200)];
     _textView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self.view addSubview: _textView];
    
    //在view上创建一个textview
    _textfield = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth-40, 140)];
    _textfield.textAlignment = NSTextAlignmentLeft;
    _textfield.delegate = self;
    [ _textView addSubview:_textfield];
    
    //创建 发布buttton
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(kScreenWidth-90, 160, 70, 30);
    _sendButton.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:201.0/255.0 blue:205.0/255.0 alpha:1];
    [_sendButton setTitle:@"发布" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_sendButton addTarget:self action:@selector(sendAct:) forControlEvents:UIControlEventTouchUpInside];
    [_textView addSubview:_sendButton];
    
    //创建label
    _textCount = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 50, 30)];
    _textCount.text = @"0/140";
    _textCount.textColor = [UIColor grayColor];
    _textCount.font = [UIFont systemFontOfSize:15];
    [_textView addSubview:_textCount];
    
    //创建笼罩视图
    _maskView = [[UIControl  alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = .4;
    _maskView.hidden = YES;

    [_maskView addTarget:self action:@selector(keyBoardHide) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_maskView belowSubview:_textView];
}

//创建推广页面视图
- (void)createAdView{

    //添加底部 toolBar
    UIToolbar *adToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 610, kScreenWidth, kNavgationHeight)];
    adToolBar.backgroundColor = [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1];
    
    //后退按钮
    UIBarButtonItem *gobackItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webDetail_goBack@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(gobackItemAct)];
    
    //中间间隔
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    item1.width =(kScreenWidth-170)/3;
    
    //前进按钮
    UIBarButtonItem *goforwardItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webDetail_goForword@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goforwardAct)];
    
    //刷新按钮
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webDetail_reload@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadAct)];
    
    //分享按钮
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webDetail_open@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openAct)];
    
    
    [adToolBar setItems:@[gobackItem,item1,goforwardItem,item1,reloadItem,item1,openItem]];
    [self.view addSubview:adToolBar];
    
    
}

//分享按钮点击跳转
- (void)openAct{
 NSLog(@"ddd3");
}

//刷新按钮点击跳转
- (void)reloadAct{
 NSLog(@"ddd2");
}

//前进按钮点击跳转
- (void)goforwardAct{
 NSLog(@"ddd1");
}

//后退按钮点击跳转
- (void)gobackItemAct{

    NSLog(@"ddd4");
}

#warning 添加点击方法 评论跳转
//底部按钮点击跳转
- (void)bottomBtnAct:(UIButton *)btn{

    NSLog(@"ggg ");
}

//点击发布按钮跳转
- (void)sendAct:(UIButton *)btn{

    if (_textfield.text.length > 2) {
        
        [self keyBoardHide];

    }
    
}

//判段 navigationBar 中间是否有item,添加详情标题
- (void)addDetailItem{

    if (![_itemType isEqualToString:@"news"] && ![_itemType isEqualToString:@"ycnews"] ) {
        
        self.webTitle.title = @"详情";
        [self.navBackBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_navBackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_navBackBtn setImage:nil forState:UIControlStateNormal];
        [self createAdView];
        
    }else{
    
        //创建底部视图
        [self createBottomView];
        

    }
    
}

- (IBAction)backButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)loadRequest{

    //加载网页
    NSURL *url = [NSURL URLWithString:_filePath];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
}

#pragma textView delegate

-(void)textViewDidChange:(UITextView *)textView{

    [self setCount];
    [self changeSendButton];
    
}
- (void)changeSendButton{

    if (_textfield.text.length > 2) {
        
        [_sendButton setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:106.0/255.0 blue:205.0/255.0 alpha:1]];
        
    }
}
- (void)setCount{

    
    _textCount.text = [NSString stringWithFormat:@"%ld/140",_textfield.text.length];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

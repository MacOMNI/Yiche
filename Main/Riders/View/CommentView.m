//
//  CommentView.m
//  YiChe
//
//  Created by imac on 15-5-6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CommentView.h"
# import "WeiboCellConfig.h"


@implementation CommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView{
    
    CGFloat height = 0;
    NSArray *agreeArr = _model.agree;

    //显示5个头像，若大于5 ，跳出for循环
    for (int i = 0; i < agreeArr.count; i++) {
        
        height = 25;
        
        UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(23*i, 3, 20, 20)];
        
        
        [headerImage setImageWithURL:[agreeArr[i] objectForKey:@"userAvatar"]];
        
        headerImage.layer.cornerRadius = 10;
        headerImage.clipsToBounds = YES;
        
        [self addSubview:headerImage];
        
        
    }
    
    NSArray *commentArr = _model.comment;
    
    for (int i = 0; i < commentArr.count; i++) {
        
        CNLabel *commentLabel = [[CNLabel alloc]initWithFrame:CGRectMake(0, 15 + 15*i, kScreenWidth, 20)];

        height += 20;
//        commentLabel.numberOfLines = 0;
        
       NSString *toUserName = [commentArr[i] objectForKey:@"toUserName"];
        if (toUserName.length >0) {
            
            toUserName = [NSString stringWithFormat:@"@%@",toUserName];
        }
        commentLabel.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//        commentLabel.font = [UIFont systemFontOfSize:12];
        
        commentLabel.text = [NSString stringWithFormat:@"%@:%@ %@",[commentArr[i] objectForKey:@"userName"],toUserName,[commentArr[i] objectForKey:@"content"]];
        
        [self addSubview:commentLabel];
        
    }
    
    self.height = height;
    
}


- (void)setModel:(CheyouHomeModel *)model
{
    _model = model;
    [self createView];
}

@end

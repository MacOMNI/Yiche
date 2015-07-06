//
//  CNLabel.h
//  CNLabelDemo
//
//  Created by wang xinkai on 15/4/20.
//  Copyright (c) 2015年 wxk. All rights reserved.
//



/*
    1.分析功能
    2.功能实现的要素，步骤
    3.需要变量和 方法
    4.方法的实现
 
 */


#import <UIKit/UIKit.h>

@class CNLabel;
@protocol CNLabelDelegate <NSObject>

@optional
-(void)labelIneract:(CNLabel*)cnLabel urlString:(NSString *)urlStr;

@end

@class CNTextView;
@interface CNLabel : UIView<UITextViewDelegate>
{
    
    CNTextView *_textView;
    
}


@property (nonatomic,copy) NSDictionary *textAttributes;
@property (nonatomic,weak) id<CNLabelDelegate> delegate;
@property (nonatomic,copy) NSString *text;


@end




@interface CNAttachment : NSTextAttachment



@end

@interface CNTextView : UITextView

@end


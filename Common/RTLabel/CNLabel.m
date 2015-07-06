//
//  CNLabel.m
//  CNLabelDemo
//
//  Created by wang xinkai on 15/4/20.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "CNLabel.h"
@class WXAttachment;


NSDictionary *faceIconDic;
@implementation CNLabel

+(void)loadFaceIconDic{
    
    if (faceIconDic) {
        return;
    }
    
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"]];
    
    NSMutableDictionary *new = [[NSMutableDictionary alloc] initWithCapacity:arr.count];
    
    for (NSDictionary *dic in arr) {
        
        NSString *key = [dic objectForKey:@"chs"];
        NSString *value = [dic objectForKey:@"png"];
        
        [new setObject:value forKey:key];
        
    }
    
    
    
    
    faceIconDic = [[NSDictionary alloc] initWithDictionary:new];
    
    
}


-(id)initWithFrame:(CGRect)frame{

    
    if (self = [super initWithFrame:frame]) {
        
        [self createTextView];
        [CNLabel loadFaceIconDic];

    }
    return self;
}

-(void)createTextView{
    
    _textView = [[CNTextView alloc] initWithFrame:self.bounds];
    _textView.delegate = self;
    _textView.editable = NO;
    _textView.backgroundColor = [UIColor clearColor];
    
    //scroll不能滚动
    _textView.scrollEnabled = NO;
    [self addSubview:_textView];
    
}


-(void)setText:(NSString *)text{
    
    _text = [text copy];
    
    
    
    [self loadAttributedString];
    
}

//加载属性文本
-(void)loadAttributedString{
    NSMutableAttributedString *att;
    
//    配置文字的属性
    if (self.textAttributes) {
         att = [[NSMutableAttributedString alloc] initWithString:_text attributes:self.textAttributes];
    }else{
         att = [[NSMutableAttributedString alloc] initWithString:_text];
    }
    
    
//    1.图文混排
    
    [self praseString:att];
    
    
//    2.超链接
    
    [self praseLinks:att];
    
//    3.高度
    [self height:att];

    
    
    _textView.attributedText = att;

//    修改CNLabel的高
    self.height = _textView.height+10;
    
}




//    1.图文混排
-(void)praseString:(NSMutableAttributedString *)att{

//    1.找range 比如 ：‘ [微笑] ’
    
    NSArray *arr = [self rangesOfSubString:@"\\[\\w{1,10}\\]"];
    


    
    for (int i = (int)arr.count-1; i>=0; i--) {
        
        
        CNAttachment *ment = [[CNAttachment alloc] init];
        
        
        NSValue *value = arr[i];
        
        NSRange range = value.rangeValue;
        
//        找到 原来的字符串
        NSString *subString = [_text substringWithRange:range];
         NSString*iconStr =   [faceIconDic objectForKey:subString];
        
//
        ment.image = [UIImage imageNamed:iconStr];
        
        
        if (iconStr) {
            //    删除 原有字符串
            [att deleteCharactersInRange:range];
        }
        
        NSAttributedString *insertStr = [NSAttributedString attributedStringWithAttachment:ment];
        
        [att insertAttributedString:insertStr atIndex:range.location];

        
    }
    
    
}
-(void)praseLinks:(NSMutableAttributedString*)attString{
    
    
    NSString*regex1= @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString*regex2= @"#[\\w]+#";
    NSString*regex3= @"@[\\w]+";
    NSArray *arr = @[regex1,regex2,regex3];
    
    
    for (NSString*regex in arr) {
        
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *items = [regular matchesInString:attString.string options:NSMatchingReportProgress range:NSMakeRange(0, attString.string.length)];
        
        
        for (int i = (int)items.count-1; i>=0; i--) {
            
            NSTextCheckingResult *res = items[i];
            
            NSRange range = res.range;
            
            
            NSString*originString = [attString.string substringWithRange:range];
            
            
            NSString *s2 = originString;
            
            s2 =  [s2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [attString addAttribute:NSLinkAttributeName value:s2 range:range];
            
            
            
            
        }
        
    }
    

}


-(void)height:(NSMutableAttributedString*)attString{
    
    CGRect  textViewFrame = _textView.frame;

    
//    CGRect frame = [attString boundingRectWithSize:CGSizeMake(textViewFrame.size.width, 99999.0f) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGRect frame = [attString boundingRectWithSize:CGSizeMake(_textView.width, 99999.0f) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    textViewFrame.size.height = frame.size.height+20;
    
    _textView.frame = textViewFrame;
//    _textView.height = frame.size.height+20;
}


-(NSArray *)rangesOfSubString:(NSString*)subS{

    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:subS options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *items = [regular matchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0, self.text.length)];
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult*res in items) {
        
        NSValue *value = [NSValue valueWithRange:res.range];
        
        [arr addObject:value];
        
    }
    
    return arr;
    
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.nextResponder touchesEnded:touches withEvent:event];
}

#pragma mark -
#pragma mark - TextView delegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
    
    if( [self.delegate respondsToSelector:@selector(labelIneract:urlString:)]){
    
        [self.delegate labelIneract:self urlString:[[URL absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
//    [[UIApplication sharedApplication] openURL:@"wb1255724468"];
//    openURL 用来实现 应用间的跳转
    
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    

    
    return YES;
}




@end




@implementation CNAttachment


// 图文混排时 ，指定图片的大小
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    
    
    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
    
}

@end
@implementation CNTextView

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.nextResponder touchesEnded:touches withEvent:event];
}

@end

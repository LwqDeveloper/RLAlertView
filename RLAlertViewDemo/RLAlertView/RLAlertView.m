//
//  RLAlertView.m
//  RLAlertView
//
//  Created by mbp on 2017/7/21.
//
//

#import "RLAlertView.h"

static const CGFloat RLAlertviewTitleFont       = 27;
static const CGFloat RLAlertviewSubTitleFont    = 17;
static const CGFloat RLAlertviewMessageFont     = 17;
static const CGFloat RLAlertviewButtonFont      = 17;

static const CGFloat RLAlertViewLeading         = 25;
static const CGFloat RLAlertViewButtonHeight    = 44;
static const CGFloat RLAlertViewLineWidth       = 0.5;
static const CGFloat RLAlertViewContentSpace    = 12;
static const CGFloat RLAlertViewContentLeading  = 12;

@interface RLAlertView ()

@property (nonatomic, weak  ) UIView *alertView;

@property (nonatomic, copy  ) void(^completion)(NSInteger buttonIndex);

@end

@implementation RLAlertView

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                      message:(NSString *)message
                   attMessage:(NSAttributedString *)attMessage
                 buttonTitles:(NSArray *)buttonTitles
                   completion:(void(^)(NSInteger buttonIndex))completion
{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]) {
        self.completion = completion;
        
        //background view
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self addSubview:bgView];
        
        //contentView
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(RLAlertViewLeading, 0, self.bounds.size.width -RLAlertViewLeading *2, 20)];
        alertView.backgroundColor = [UIColor whiteColor];
        alertView.layer.cornerRadius = 5.0;
        alertView.clipsToBounds = YES;
        [self addSubview:self.alertView = alertView];
        
        CGFloat topY_ = RLAlertViewContentSpace;
        
        //title
        if (title.length > 0) {
            UILabel *titleLabel = [self addLabelTitle:title color:[UIColor blackColor] font:[UIFont systemFontOfSize:RLAlertviewTitleFont]];
            [self rl_resetView:titleLabel frameKey:@"y" value:topY_];
            topY_ += titleLabel.bounds.size.height;
            topY_ += RLAlertViewContentSpace;
        }
        
        //subTitle
        if (subTitle.length > 0) {
            UILabel *titleLabel = [self addLabelTitle:subTitle color:[UIColor blackColor] font:[UIFont systemFontOfSize:RLAlertviewSubTitleFont]];
            [self rl_resetView:titleLabel frameKey:@"y" value:topY_];
            topY_ += titleLabel.bounds.size.height;
            topY_ += RLAlertViewContentSpace;
        }

        //message
        if (message.length > 0 || attMessage.string.length > 0) {
            UITextView *messageView = [[UITextView alloc] initWithFrame:CGRectMake(RLAlertViewContentLeading, topY_, self.alertView.bounds.size.width -RLAlertViewContentLeading *2, 20)];
            if (message.length > 0) {
                messageView.text = message;
            } else if (attMessage.string.length > 0) {
                messageView.attributedText = attMessage;
            }
            messageView.font = [UIFont systemFontOfSize:RLAlertviewMessageFont];
            messageView.textColor = [UIColor darkGrayColor];
            messageView.editable = NO;
            messageView.showsVerticalScrollIndicator = NO;
            [self.alertView addSubview:messageView];

            CGFloat maxMessageViewHeight = self.bounds.size.height -130*2 -RLAlertViewButtonHeight -topY_;
            CGFloat messageContentHeight = [self heightForTextView:messageView width:messageView.bounds.size.width];
            if (messageContentHeight <= maxMessageViewHeight) {
                [self rl_resetView:messageView frameKey:@"height" value:messageContentHeight];
            } else {
                [self rl_resetView:messageView frameKey:@"height" value:maxMessageViewHeight];
            }
            topY_ += messageView.bounds.size.height;
            topY_ += RLAlertViewContentSpace;
        }
        
        //buttons
        if (buttonTitles.count > 0) {
            for (NSInteger i = 0; i < buttonTitles.count; i ++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 +i;
                button.frame = CGRectMake(alertView.bounds.size.width /buttonTitles.count *i, topY_, alertView.bounds.size.width /buttonTitles.count, RLAlertViewButtonHeight);
                button.titleLabel.font = [UIFont systemFontOfSize:RLAlertviewButtonFont];
                [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
                [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor clearColor];
                [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
                [button addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
                [button addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragEnter];
                [button addTarget:self action:@selector(clearBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
                [alertView addSubview:button];
                
                //v line
                if (i > 0) {
                    UIView *vLine = [self lineFrame:CGRectMake(0, 0, RLAlertViewLineWidth, button.bounds.size.height)];
                    [button addSubview:vLine];
                }
            }
            //h line
            UIView *hLine = [self lineFrame:CGRectMake(0, topY_, alertView.bounds.size.width, RLAlertViewLineWidth)];
            [alertView addSubview:hLine];
            
            topY_ += RLAlertViewButtonHeight;
        }
        [self rl_resetView:self.alertView frameKey:@"height" value:topY_];
    }
    return self;
}

#pragma mark - event response
- (void)buttonTap:(UIButton *)button
{
    if (self.completion) {
        self.completion(button.tag -100);
    }
    [self rl_hide];
}

- (void)setBackgroundColorForButton:(UIButton *)sender
{
    [sender setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
}

- (void)clearBackgroundColorForButton:(UIButton *)sender
{
    [sender setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - custom method
- (CGFloat)calculatHeightOfLabel:(UILabel *)label
{
    return [self heightOfText:label.text width:label.bounds.size.width font:label.font];
}

- (CGFloat)heightOfText:(NSString *)text width:(CGFloat)width font:(UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.height;
}

- (void)rl_showInView:(UIView *)view
{
    [self rl_resetView:self.alertView frameKey:@"y" value:view.bounds.size.height /2. -self.alertView.bounds.size.height /2.];
    [super rl_showInView:view];
}

#pragma mark - custom view 
- (UILabel *)addLabelTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RLAlertViewContentLeading, 0, self.alertView.bounds.size.width -RLAlertViewContentLeading *2, 20)];
    label.font = font;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    if (title.length > 0) {
        label.text = title;
        [self rl_resetView:label frameKey:@"height" value:[self calculatHeightOfLabel:label]];
        [self.alertView addSubview:label];
    } else {
        [self rl_resetView:label frameKey:@"height" value:0];
    }
    return label;
}

- (UIView *)lineFrame:(CGRect)frame
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor lightGrayColor];
    return line;
}

- (CGFloat)heightForTextView:(UITextView *)textView width:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}


- (CGFloat)heightOfText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size.height;
}

#pragma mark -
+ (instancetype)showAlertWithTitle:(NSString *)title
                        completion:(void(^)(NSInteger buttonIndex))completion
{
    return [self showAlertWithTitle:title message:@"" buttonTitles:@[@"取消",@"确定"] completion:completion];
}

+ (instancetype)showAlertWithMessage:(NSString *)message
                          completion:(void(^)(NSInteger buttonIndex))completion
{
    return [self showAlertWithTitle:@"" message:message buttonTitles:@[@"取消",@"确定"] completion:completion];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(void(^)(NSInteger buttonIndex))completion
{
    return [self showAlertWithTitle:title message:message buttonTitles:@[@"取消",@"确定"] completion:completion];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                      buttonTitles:(NSArray *)buttonTitles
                        completion:(void(^)(NSInteger buttonIndex))completion
{
    return [self showAlertWithTitle:title subTitle:nil message:message attMessage:nil buttonTitles:buttonTitles completion:completion];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                          subTitle:(NSString *)subTitle
                           message:(NSString *)message
                        attMessage:(NSAttributedString *)attMessage
                      buttonTitles:(NSArray *)buttonTitles
                        completion:(void(^)(NSInteger buttonIndex))completion
{
    RLAlertView *alertView = [[self alloc] initWithTitle:title
                                                subTitle:subTitle
                                                 message:message
                                              attMessage:attMessage
                                            buttonTitles:buttonTitles
                                              completion:completion];
    [alertView rl_showInView:[[UIApplication sharedApplication] keyWindow]];
    return alertView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

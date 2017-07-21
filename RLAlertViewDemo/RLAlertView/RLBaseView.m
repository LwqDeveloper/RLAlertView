//
//  RLBaseView.m
//  RLAlertView
//
//  Created by mbp on 2017/7/21.
//
//

#import "RLBaseView.h"

@implementation RLBaseView

- (void)rl_addBgView
{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.tag = 10086;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rl_hide)]];
    [self addSubview:view];
    [self insertSubview:view atIndex:0];
}

- (void)rl_removeBgView
{
    UIView *view = [self viewWithTag:10086];
    [view removeFromSuperview];
}

- (void)rl_showInView:(UIView *)view
{
    if (!self.superview) {
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }
    if (![self.superview isEqual:view]) {
        [self removeFromSuperview];
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }
    
    [view bringSubviewToFront:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.hidden = NO;
    }];
}

- (void)rl_hide
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.hidden = YES;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)rl_resetView:(UIView *)view
            frameKey:(NSString *)frameKey
               value:(CGFloat)value
{
    CGRect newFrame = view.frame;
    if ([frameKey isEqualToString:@"height"]) {
        newFrame.size.height = value;
    } else if ([frameKey isEqualToString:@"width"]) {
        newFrame.size.width = value;
    } else if ([frameKey isEqualToString:@"x"]) {
        newFrame.origin.x = value;
    } else if ([frameKey isEqualToString:@"y"]) {
        newFrame.origin.y = value;
    }
    view.frame = newFrame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

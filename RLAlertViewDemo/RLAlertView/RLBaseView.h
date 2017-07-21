//
//  RLBaseView.h
//  RLAlertView
//
//  Created by mbp on 2017/7/21.
//
//

#import <UIKit/UIKit.h>

@interface RLBaseView : UIView

- (void)rl_addBgView;

- (void)rl_removeBgView;

- (void)rl_showInView:(UIView *)view;

- (void)rl_hide;

- (void)rl_resetView:(UIView *)view
            frameKey:(NSString *)frameKey
               value:(CGFloat)value;

@end

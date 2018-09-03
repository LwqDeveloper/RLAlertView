//
//  RLAlertView.h
//  RLAlertView
//
//  Created by mbp on 2017/7/21.
//
//

#import "RLBaseView.h"

@interface RLAlertView : RLBaseView

+ (instancetype)showAlertWithTitle:(NSString *)title
                        completion:(void(^)(NSInteger buttonIndex))completion;

+ (instancetype)showAlertWithMessage:(NSString *)message
                          completion:(void(^)(NSInteger buttonIndex))completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(void(^)(NSInteger buttonIndex))completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                      buttonTitles:(NSArray *)buttonTitles
                        completion:(void(^)(NSInteger buttonIndex))completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                          subTitle:(NSString *)subTitle
                           message:(NSString *)message
                        attMessage:(NSAttributedString *)attMessage
                      buttonTitles:(NSArray *)buttonTitles
                        completion:(void(^)(NSInteger buttonIndex))completion;

@end

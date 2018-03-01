//
//  XGJSBShareView.h
//  XGJSBridgeLibrary
//
//  Created by ZJ-Jie on 2017/7/4.
//  Copyright © 2017年 zj_lostself@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XGJSBShareViewDelegate <NSObject>

@optional
- (void)xgjsb_handleShareButtonWithIndex:(NSInteger)index;

@end

@interface XGJSBShareView : UIView

@property(nonatomic, weak) id<XGJSBShareViewDelegate> delegate;

+ (instancetype)createShareAlertWithData:(NSMutableArray *)datas;

+ (instancetype)createShareAlertWithScreenNum:(NSInteger)num data:(NSMutableArray *)datas;

- (void)show;

- (void)showInVC:(__kindof UIViewController *)vc;

@end

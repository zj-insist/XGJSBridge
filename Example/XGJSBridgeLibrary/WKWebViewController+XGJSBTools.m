//
//  WKWebViewController+XGJSBTools.m
//  XGJSBridgeLibrary
//
//  Created by ZJ-Jie on 2017/8/10.
//  Copyright © 2017年 zj_lostself@163.com. All rights reserved.
//

#import "WKWebViewController+XGJSBTools.h"
#import <XGJSBridge.h>

@interface WKWebViewController()<XGJSBWKWebViewNativeFunctionDelegate,XGJSBShareViewDelegate>

@end

@implementation WKWebViewController (XGJSBTools)

- (void)xgjsb_checkJsApiWithOption:(id)option {
    NSLog(@"%@",option);
}

- (void)xgjsb_shareWithOption:(id)option {
    [self shareTest];
}

#pragma mark - test

- (void)shareTest {
    XGJSBShareModel *model1 = [[XGJSBShareModel alloc] initWithShareTitle:@"微信好友" type:XGJSBShareTypeWeChat data:nil];
    XGJSBShareModel *model2 = [[XGJSBShareModel alloc] initWithShareTitle:@"微信朋友圈" type:XGJSBShareTypeWeChatTimeLine data:nil];
    XGJSBShareModel *model3 = [[XGJSBShareModel alloc] initWithShareTitle:@"复制链接" type:XGJSBShareTypeCopyUrl data:nil];
    NSMutableArray *arr =[NSMutableArray arrayWithObjects:model1,model2,model3,model1,model2,model3, nil];
    
    //create
    XGJSBShareView *share = [XGJSBShareView createShareAlertWithData:arr];
    share.delegate = self;
    [share show];
}

- (void)xgjsb_handleShareButtonWithIndex:(NSInteger)index {
    NSLog(@"%ld",index);
}

@end

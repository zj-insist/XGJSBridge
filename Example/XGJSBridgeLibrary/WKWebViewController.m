//
//  WKWebViewController.m
//  WKWebViewMessageHandlerDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "XGJSBShareView.h"

#import <YYKit.h>
#import "XGJSBridge.h"



@interface WKWebViewController ()<WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,XGJSBWKWebViewNativeFunctionDelegate,XGJSBWKWebViewUserContentDelegate,XGJSBShareViewDelegate>

//@property(nonatomic, strong)WKWebView *webView;
@end

@implementation WKWebViewController

- (void)dealloc {
    [self.webView xgjsb_removeScriptMessage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"XGJSBridge";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWKWebView];
}

- (void)initWKWebView {

    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:[WKWebView xgjsb_createConfigurationWithHandle:self]];
    
    //设置解析的代理
//    self.webView.userContentDelegate = self;
    self.webView.functionDelegate = self;
    self.webView.UIDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.16.25.117:8081/"]]];
    
    [self.view addSubview:self.webView];
}

#pragma mark -- WKScriptMessageHandler
/**
 *  JS 调用 OC 时 webview 会调用此方法
 *
 *  @param userContentController  webview中配置的userContentController 信息
 *  @param message                JS执行传递的消息
 */

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //JS调用OC方法
    
    [self.webView xgjsb_responseWebViewWithReceiveMessage:message];
}

- (IBAction)shareTest:(id)sender {
    XGJSBShareModel *model1 = [[XGJSBShareModel alloc] initWithShareTitle:@"微信好友" type:XGJSBShareTypeWeChat data:nil];
    XGJSBShareModel *model2 = [[XGJSBShareModel alloc] initWithShareTitle:@"微信朋友圈" type:XGJSBShareTypeWeChatTimeLine data:nil];
    XGJSBShareModel *model3 = [[XGJSBShareModel alloc] initWithShareTitle:@"复制链接" type:XGJSBShareTypeCopyUrl data:nil];
    NSMutableArray *arr =[NSMutableArray arrayWithObjects:model1,model2,model3, nil];
    [self createBottomAlertWithData:arr];
}

- (void)createBottomAlertWithData:(NSMutableArray *)datas {
    XGJSBShareView *share = [XGJSBShareView createShareAlertWithData:datas];
    share.delegate = self;
    [share show];
}

- (void)xgjsb_handleShareButtonWithIndex:(NSInteger)index {
    NSLog(@"%ld",index);
}

- (IBAction)r:(id)sender {
    [self.webView reload];
}

@end

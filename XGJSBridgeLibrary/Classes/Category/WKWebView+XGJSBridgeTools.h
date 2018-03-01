//
//  WKWebView+XGJSBridgeTools.h
//  XGJSBridge
//
//  Created by ZJ-Jie on 2017/6/21.
//  Copyright © 2017年 Jie. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "XGJSBridgeProtocol.h"

@class XGJSBridgeModel;

@interface WKWebView (XGJSBridgeTools)

@property(nonatomic, strong, readonly) NSMutableArray *postMessageNames;                /**  显示注入JS端的内容数组,用于移除操作   */

/**  完全自已处理JS发来的消息 */
@property(nonatomic, weak) id<XGJSBWKWebViewUserContentDelegate> userContentDelegate;

/**
 用默认的处理，只实现响应的对应关系就好
 */
@property(nonatomic, weak) id<XGJSBWKWebViewNativeFunctionDelegate> functionDelegate;


/**
 移除注入的JS，如果不移除，会造成内存泄露
 */
// !!!: 重要
- (void)xgjsb_removeScriptMessage;

/**
 创建注入到JS端的configuration，支持多个注入

 @param handle <#handle description#>
 @param names <#names description#>
 @return <#return value description#>
 */
+ (WKWebViewConfiguration *)xgjsb_createConfigurationWithHandle:(id <WKScriptMessageHandler>)handle postMessageNames:(NSString *)names, ... ;

/**
 创建默认configuration，包含一个名为XGJSBCommonJSAPI的注入对象

 @param handle <#handle description#>
 @return <#return value description#>
 */
+ (WKWebViewConfiguration *)xgjsb_createConfigurationWithHandle:(id <WKScriptMessageHandler>)handle;

/**
 处理从JS端接收的数据，并根据内容选择映射方法

 @param messgae <#messgae description#>
 */
- (void)xgjsb_responseWebViewWithReceiveMessage:(WKScriptMessage *)messgae;


/**
 回调

 @param option <#option description#>
 @param result <#result description#>
 @param param <#param description#>
 */
- (void)xgjsb_callBackWithOption:(XGJSBridgeModel *)option result:(XGJSBridgeReturnResultType)result parameter:(id)param;

- (void)xgjsb_callBackWithWebView:(WKWebView *)webView result:(XGJSBridgeReturnResultType)result callBackName:(NSString *)name parameter:(id)param;

@end

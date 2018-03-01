//
//  XGJSBridgeProtocol.h
//  XGJSBridge
//
//  Created by ZJ-Jie on 2017/6/21.
//  Copyright © 2017年 Jie. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 回调给Web端，Native端的执行结果

 - XGJSBridgeReturnResultTypeSuccess: 成功
 - XGJSBridgeReturnResultTypeCancel: 取消
 - XGJSBridgeReturnResultTypeFail: 失败
 */
typedef NS_ENUM(NSUInteger, XGJSBridgeReturnResultType) {
    XGJSBridgeReturnResultTypeSuccess,
    XGJSBridgeReturnResultTypeCancel,
    XGJSBridgeReturnResultTypeFail,
};

/**
 接收JS端信息后的映射功能到相应处理方法
 */
@protocol XGJSBWKWebViewUserContentDelegate <NSObject>

@optional
- (void)xgjsb_userContentWithDicAtIndex_0:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_1:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_2:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_3:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_4:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_5:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_6:(id)dic;
- (void)xgjsb_userContentWithDicAtIndex_7:(id)dic;
//支持继续扩展

@end

@class WKWebView;

/**
 XGJSBridge中的功能以及回调给JS的处理
 */
@protocol XGJSBWKWebViewNativeFunctionDelegate <NSObject>

@optional

/**
 回调js 默认实现一份, 如果用户实现那么就按用户实现的完成
 @param webView 执行的web
 @param result 执行结果
 @param param 回调参数
 */
- (void)xgjsb_callBackHandleWithWebView:(WKWebView *)webView result:(XGJSBridgeReturnResultType)result callBackName:(NSString *)name parameter:(id)param;

/**
 和h5端协商好的type对应app操作的方法mapper ,注意所有的方法都应该有一个参数，传h5传入的信息
 如果客户端实现，那么就调用客户端的方法，如果没有实现，那么认为这个type名就是方法名，如果方法名的方法也没有的，那么就忽略h5的调用方法
 */
- (nullable NSDictionary<NSString *, id> *)xgjsb_userContentActionMapper;
@end

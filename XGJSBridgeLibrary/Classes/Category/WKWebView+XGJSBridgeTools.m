//
//  WKWebView+XGJSBridgeTools.m
//  XGJSBridge
//
//  Created by ZJ-Jie on 2017/6/21.
//  Copyright © 2017年 Jie. All rights reserved.
//

#import "WKWebView+XGJSBridgeTools.h"
#import <objc/runtime.h>

#import "XGJSBridgeConstant.h"
#import "XGJSBridgeModel.h"
#import <YYKit/YYKit.h>
#import "XGJSBShareView.h"

#define XGJSBDelegateMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"%@——方法与业务耦合，必须重新实现", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

static NSMutableArray *temp = nil;

static char userContentDelegateKeyId;
static char functionDelegateKeyId;

@implementation WKWebView (XGJSBridgeTools)

#pragma mark - class methods

+ (WKWebViewConfiguration *)xgjsb_createConfigurationWithHandle:(id <WKScriptMessageHandler>)handle postMessageNames:(NSString *)names, ... {
    
    temp = nil;
    if (!names) return nil;
    
    NSMutableArray *namesArray = [NSMutableArray array];
    NSString *nameItem = nil;
    
    va_list argumentList;
    [namesArray addObject:names];
    
    va_start(argumentList, names);
    while ((nameItem = va_arg(argumentList, NSString *))) {
        [namesArray addObject:nameItem];
    }
    va_end(argumentList);
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
    for (NSString *str in namesArray) {
        [userContentController addScriptMessageHandler:handle name:str];
    }
    
    configuration.userContentController = userContentController;
    
    temp = [namesArray mutableCopy];
    
    return configuration;
}


+ (WKWebViewConfiguration *)xgjsb_createConfigurationWithHandle:(id <WKScriptMessageHandler>)handle {
    return [WKWebView xgjsb_createConfigurationWithHandle:handle postMessageNames:XGJSBCommonJSAPI,nil];
}

- (void)xgjsb_removeScriptMessage {
    for (NSString *name in self.postMessageNames) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:name];
    }
}

#pragma mark - publish methods

- (void)xgjsb_responseWebViewWithReceiveMessage:(WKScriptMessage *)messgae {
    __weak __typeof(self)weakSelf = self;
    [self.postMessageNames enumerateObjectsUsingBlock:^(NSString  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([messgae.name isEqualToString:obj]) {
            NSString *methodsName = [NSString stringWithFormat:@"xgjsb_userContentWithDicAtIndex_%ld:",(unsigned long)idx];
            SEL method = NSSelectorFromString(methodsName);
            if (strongSelf.userContentDelegate && [strongSelf.userContentDelegate respondsToSelector:method]) {
                ((void (*)(id, SEL, id))[(NSObject *)strongSelf.userContentDelegate methodForSelector:method])(strongSelf.userContentDelegate, method, messgae.body);
            } else if ([strongSelf respondsToSelector:method]) {
                ((void (*)(id, SEL, id))[strongSelf methodForSelector:method])(strongSelf, method, messgae.body);
            }
            *stop = YES;
        }
    }];
}

-(void)xgjsb_userContentWithDicAtIndex_0:(id)dic {
    XGJSBridgeModel *model = [XGJSBridgeModel modelWithJSON:dic];
    if (!model || !model.type || ![model.type isKindOfClass:[NSString class]]) return;

    ///1.先看用户有没有实现 类型名-方法名的mapper，有就用方法名
    NSString *methodName = nil;
    NSDictionary *functionMapper = nil;
    if ([self.functionDelegate respondsToSelector:@selector(xgjsb_userContentActionMapper)]) {
        functionMapper = [self.functionDelegate xgjsb_userContentActionMapper];
    }

    if ([functionMapper.allKeys containsObject:model.type]) {
        methodName = [functionMapper objectForKey:model.type];
    }else if ([self.functionDelegate respondsToSelector:NSSelectorFromString(model.type)]) {
        methodName = model.type;
    }else if ([self.functionDelegate respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:", model.type])]) {
        methodName = [NSString stringWithFormat:@"%@:", model.type];
    }else {
        ///都没有实现直接丢弃
        ///判断有没有callback,有直接返回失败
        if (model.callBackId.length > 0) {
            [self xgjsb_callBackWithOption:model result:XGJSBridgeReturnResultTypeFail parameter:nil];
        }
        return;
    }

    SEL method = NSSelectorFromString(methodName);
    if (self.functionDelegate && [self.functionDelegate respondsToSelector:method]) {
        ((void (*)(id, SEL, id))[(NSObject *)self.functionDelegate methodForSelector:method])(self.functionDelegate, method, model);
    } else if ([self respondsToSelector:method]) {
        ((void (*)(id, SEL, id))[self methodForSelector:method])(self, method, model);
    }
}

- (void)xgjsb_callBackHandleWithWebView:(WKWebView *)webView result:(XGJSBridgeReturnResultType)result callBackName:(NSString *)name parameter:(id)param {
    if (!name) return;
    
    //拼接回调函数名
    NSString *callBackMethod = [NSString stringWithFormat:@"window.__JSBridge.callbackObj.%@",name];

    //拼接回调函数的参数
    XGJSBridgeCallBackModel *callBackModel = [[XGJSBridgeCallBackModel alloc] initWithResult:result data:param];
    
    NSString *modelJson = [callBackModel modelToJSONString];
    
    NSString *jsStr = [NSString stringWithFormat:@"%@('%@')",callBackMethod,modelJson];
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}

#pragma mark - tools methods
- (void)xgjsb_callBackWithWebView:(WKWebView *)webView result:(XGJSBridgeReturnResultType)result callBackName:(NSString *)name parameter:(id)param {
    if (self.functionDelegate && [self.functionDelegate respondsToSelector:@selector(xgjsb_callBackHandleWithWebView:result:callBackName:parameter:)]) {
        [self.functionDelegate xgjsb_callBackHandleWithWebView:webView result:result callBackName:name parameter:param];
    } else if ([self respondsToSelector:@selector(xgjsb_callBackHandleWithWebView:result:callBackName:parameter:)]) {
        [self xgjsb_callBackHandleWithWebView:webView result:result callBackName:name parameter:param];
    } else {
        XGJSBDelegateMethodNotImplemented();
    }
}

- (void)xgjsb_callBackWithOption:(XGJSBridgeModel *)option result:(XGJSBridgeReturnResultType)result parameter:(id)param {
    [self xgjsb_callBackWithWebView:self result:result callBackName:option.callBackId parameter:param];
}


#pragma mark - getter and setter

- (void)setUserContentDelegate:(id<XGJSBWKWebViewUserContentDelegate>)userContentDelegate {
    objc_setAssociatedObject(self, &userContentDelegateKeyId, userContentDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XGJSBWKWebViewUserContentDelegate>)userContentDelegate {
    return objc_getAssociatedObject(self, &userContentDelegateKeyId);
}

- (void)setFunctionDelegate:(id<XGJSBWKWebViewNativeFunctionDelegate>)functionDelegate {
    objc_setAssociatedObject(self, &functionDelegateKeyId, functionDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XGJSBWKWebViewNativeFunctionDelegate>)functionDelegate {
    return objc_getAssociatedObject(self, &functionDelegateKeyId);
}

- (NSMutableArray *)postMessageNames {
    return temp;
}


@end

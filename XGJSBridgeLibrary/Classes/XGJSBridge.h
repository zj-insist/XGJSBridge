//
//  XGJSBridge.h
//  XGJSBridge
//
//  Created by ZJ-Jie on 2017/6/21.
//  Copyright © 2017年 Jie. All rights reserved.
//


#import <Foundation/Foundation.h>

#if __has_include(<XGJSBridge/XGJSBridge.h>)

#import <XGJSBridge/XGJSBridgeModel.h>
#import <XGJSBridge/XGJSBridgeConstant.h>
#import <XGJSBridge/WKWebView+XGJSBridgeTools.h>
#import <XGJSBridge/XGJSBridgeProtocol.h>
#import <XGJSBridge/XGJSBShareModel.h>
#import <XGJSBridge/XGJSBShareView.h>

#else

#import "XGJSBShareView.h"
#import "XGJSBShareModel.h"
#import "XGJSBridgeModel.h"
#import "XGJSBridgeConstant.h"
#import "WKWebView+XGJSBridgeTools.h"
#import "XGJSBridgeProtocol.h"

#endif

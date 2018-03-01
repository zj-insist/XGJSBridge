//
//  XGJSBridgeModel.m
//  XGJSBridge
//
//  Created by ZJ-Jie on 2017/6/20.
//  Copyright © 2017年 Jie. All rights reserved.
//

#import "XGJSBridgeModel.h"
#import <YYKit/YYKit.h>

@implementation XGJSBridgeOption

- (NSString *)description {
    return [NSString stringWithFormat:@" cancel: %@\n confirm: %@\n des: %@\n imgUrl: %@\n menuList: %@\n page: %@\n time: %ld\n title: %@\n type: %@\n url: %@\n data: %@\n otherData: %@\n", self.cancel,self.confirm,self.des,self.imgUrl,self.menuList,self.page,self.time,self.title,self.type,self.url,self.data,self.otherData];
}

@end

@implementation XGJSBridgeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"callBackId":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"option":XGJSBridgeOption.class};
}

//预留，转换成枚举
- (XGJSBridgeReciveType)typeEnum {
    if (![self.type isKindOfClass:[NSString class]]) return XGJSBridgeReciveTypeOthers;
    
    if ([self.type isEqualToString:@"checkJsApi"]) {
        _typeEnum = XGJSBridgeReciveTypeCheckJsApi;
    } else if ([self.type isEqualToString:@"showLoading"]) {
        _typeEnum = XGJSBridgeReciveTypeShowLoading;
    } else if ([self.type isEqualToString:@"hideLoading"]) {
        _typeEnum = XGJSBridgeReciveTypeHideLoading;
    } else if ([self.type isEqualToString:@"toast"]) {
        _typeEnum = XGJSBridgeReciveTypeToast;
    } else if ([self.type isEqualToString:@"alert"]) {
        _typeEnum = XGJSBridgeReciveTypeAlert;
    } else if ([self.type isEqualToString:@"confirm"]) {
        _typeEnum = XGJSBridgeReciveTypeConfirm;
    } else if ([self.type isEqualToString:@"getData"]) {
        _typeEnum = XGJSBridgeReciveTypeGetData;
    } else if ([self.type isEqualToString:@"postData"]) {
        _typeEnum = XGJSBridgeReciveTypePostData;
    } else if ([self.type isEqualToString:@"share"]) {
        _typeEnum = XGJSBridgeReciveTypeShare;
    } else if ([self.type isEqualToString:@"uploadImage"]) {
        _typeEnum = XGJSBridgeReciveTypeUploadImage;
    } else if ([self.type isEqualToString:@"gotoNative"]) {
        _typeEnum = XGJSBridgeReciveTypeGotoNative;
    } else if ([self.type isEqualToString:@"gotoWebView"]) {
        _typeEnum = XGJSBridgeReciveTypeGotoWebView;
    } else if ([self.type isEqualToString:@"closeWebView"]) {
        _typeEnum = XGJSBridgeReciveTypeCloseWebView;
    } else if ([self.type isEqualToString:@"refreshPage"]) {
        _typeEnum = XGJSBridgeReciveTypeRefreshPage;
    } else if ([self.type isEqualToString:@"disablePullRefresh"]) {
        _typeEnum = XGJSBridgeReciveTypeDisablePullRefresh;
    } else if ([self.type isEqualToString:@"disableSlideSwipe"]) {
        _typeEnum = XGJSBridgeReciveTypeDisableSlideSwipe;
    } else if ([self.type isEqualToString:@"setTitle"]) {
        _typeEnum = XGJSBridgeReciveTypeSetTitle;
    } else if ([self.type isEqualToString:@"showOptionMenu"]) {
        _typeEnum = XGJSBridgeReciveTypeShowOptionMenu;
    } else if ([self.type isEqualToString:@"hideOptionMenu"]) {
        _typeEnum = XGJSBridgeReciveTypeHideOptionMenu;
    } else if ([self.type isEqualToString:@"showMenuItems"]) {
        _typeEnum = XGJSBridgeReciveTypeShowMenuItems;
    } else if ([self.type isEqualToString:@"hideMenuItems"]) {
        _typeEnum = XGJSBridgeReciveTypeHideMenuItems;
    } else if ([self.type isEqualToString:@"showAllNonBaseMenuItem"]) {
        _typeEnum = XGJSBridgeReciveTypeShowAllNonBaseMenuItem;
    } else if ([self.type isEqualToString:@"hideAllNonBaseMenuItem"]) {
        _typeEnum = XGJSBridgeReciveTypeHideAllNonBaseMenuItem;
    } else {
        _typeEnum = XGJSBridgeReciveTypeOthers;
    }
    return _typeEnum;
}

- (NSString *)description {
    return [NSString stringWithFormat:@" callBackId: %@\n option: %@\n type: %@\n portId: %ld\n otherData: %@\n", self.callBackId,self.option,self.type,self.portId,self.otherData];
}

@end

@implementation XGJSBridgeCallBackModel

- (instancetype)initWithResult:(XGJSBridgeReturnResultType)result data:(id)data {
    self = [super init];
    if (self) {
        switch (result) {
            case XGJSBridgeReturnResultTypeSuccess:
                _type = @"success";
                break;
            case XGJSBridgeReturnResultTypeCancel:
                _type = @"cancel";
                break;
            default:
                _type = @"fail";
                break;
        }
        _data = data;
    }
    return self;
}

- (void)setType:(NSString *)type {
    if ([type isEqualToString:@"success"] || [type isEqualToString:@"cancel"] || [type isEqualToString:@"fail"]) {
        _type = type;
    }
}

@end

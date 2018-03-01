//
//  XGJSBridgeModel.h
//  XGJSBridge
//
//  Created by ZJ-Jie on 2017/6/20.
//  Copyright © 2017年 Jie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XGJSBridgeProtocol.h"

//TODO:如果需要对字符串类型多次判断，使用枚举效率更高
typedef NS_ENUM(NSUInteger, XGJSBridgeReciveType) {
    XGJSBridgeReciveTypeCheckJsApi,
    XGJSBridgeReciveTypeShowLoading,
    XGJSBridgeReciveTypeHideLoading,
    XGJSBridgeReciveTypeToast,
    XGJSBridgeReciveTypeAlert,
    XGJSBridgeReciveTypeConfirm,
    XGJSBridgeReciveTypeGetData,
    XGJSBridgeReciveTypePostData,
    XGJSBridgeReciveTypeShare,
    XGJSBridgeReciveTypeUploadImage,
    XGJSBridgeReciveTypeGotoNative,
    XGJSBridgeReciveTypeGotoWebView,
    XGJSBridgeReciveTypeCloseWebView,
    XGJSBridgeReciveTypeRefreshPage,
    XGJSBridgeReciveTypeDisablePullRefresh,
    XGJSBridgeReciveTypeDisableSlideSwipe,
    XGJSBridgeReciveTypeSetTitle,
    XGJSBridgeReciveTypeShowOptionMenu,
    XGJSBridgeReciveTypeHideOptionMenu,
    XGJSBridgeReciveTypeShowMenuItems,
    XGJSBridgeReciveTypeHideMenuItems,
    XGJSBridgeReciveTypeShowAllNonBaseMenuItem,
    XGJSBridgeReciveTypeHideAllNonBaseMenuItem,
    XGJSBridgeReciveTypeOthers,
};

@interface XGJSBridgeOption : NSObject

@property (nonatomic, copy) NSString *cancel;
@property (nonatomic, copy) NSString *confirm;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, strong) NSArray *menuList;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id type;
@property (nonatomic, copy) NSString *url;
@property(nonatomic, strong) id data;


@property(nonatomic, strong) id otherData;              /**     预留字段  */

@end

@interface XGJSBridgeModel : NSObject

@property(nonatomic, copy) NSString *callBackId;
@property (nonatomic, strong) XGJSBridgeOption *option;
@property (nonatomic, copy) NSString *type;

@property(nonatomic, assign) XGJSBridgeReciveType typeEnum;     /**    映射接收类型为枚举   */

@property (nonatomic, assign) NSInteger portId;         /**     预留Id   */
@property(nonatomic, strong) id otherData;              /**     预留字段  */

@end


/**
 回调给JS的Model
 */
@interface XGJSBridgeCallBackModel : NSObject

//声明属性为只读类型，使用YYModel转换为Json会不成功，具体原因需要参考源码…
@property(nonatomic, copy) NSString *type;              /**     回调给JS端的结果，只支持"success","cancel","fail"三种赋值，其他赋值无效  */
@property(nonatomic, strong) id data;

- (instancetype)initWithResult:(XGJSBridgeReturnResultType)result data:(id)data;

@end



//
//  XGJSBShareModel.h
//  Pods
//
//  Created by ZJ-Jie on 2017/7/5.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XGJSBShareType) {
    XGJSBShareTypeWeChat,
    XGJSBShareTypeWeChatTimeLine,
    XGJSBShareTypeCopyUrl,
    XGJSBShareTypeOther
};

@interface XGJSBShareModel : NSObject

@property(nonatomic, copy, readonly) NSString *shareTitle;
@property(nonatomic, strong, readonly) id shareData;
@property(nonatomic, assign, readonly) XGJSBShareType shareType;
//预留
@property(nonatomic, strong) id otherData;

@property(nonatomic, copy) NSString *imageName;

- (instancetype)initWithShareTitle:(NSString *)shareTitle type:(XGJSBShareType)shareType data:(id)shareData;

- (instancetype)initWithShareTitle:(NSString *)shareTitle type:(XGJSBShareType)shareType data:(id)shareData otherData:(id)otherData;

@end

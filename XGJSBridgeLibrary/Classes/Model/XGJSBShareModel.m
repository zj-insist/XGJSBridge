//
//  XGJSBShareModel.m
//  Pods
//
//  Created by ZJ-Jie on 2017/7/5.
//
//

#import "XGJSBShareModel.h"

@implementation XGJSBShareModel

- (instancetype)initWithShareTitle:(NSString *)shareTitle type:(XGJSBShareType)shareType data:(id)shareData {
    
    return [self initWithShareTitle:shareTitle type:shareType data:shareData otherData:nil];
}

- (instancetype)initWithShareTitle:(NSString *)shareTitle type:(XGJSBShareType)shareType data:(id)shareData otherData:(id)otherData {
    self = [super init];
    if (self) {
        _shareTitle = shareTitle;
        _shareType = shareType;
        _shareData = shareData;
        _otherData = otherData;
    }
    return self;
}

- (NSString *)imageName {
    switch (self.shareType) {
        case XGJSBShareTypeWeChat:
            return @"share_icon_wx_talk";
        case XGJSBShareTypeWeChatTimeLine:
            return @"share_icon_wx_tl";
        case XGJSBShareTypeCopyUrl:
            return @"share_icon_url";
        default:
            return @"share_icon_url";
    }
}

@end

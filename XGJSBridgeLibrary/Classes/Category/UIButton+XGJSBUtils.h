//
//  UIButton+XGJSBUtils.h
//  Pods
//
//  Created by ZJ-Jie on 2017/7/5.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XGJSBButtonImagePosition) {
    XGJSBButtonImagePositionLeft,
    XGJSBButtonImagePositionRight,
    XGJSBButtonImagePositionTop,
    XGJSBButtonImagePositionBottom
};

@interface UIButton (XGJSBUtils)

- (void)xgjsb_adpetiPhoneXBottom;

- (void)xgjsb_setTitleAndImagePosition:(XGJSBButtonImagePosition)imagePosition spacing:(float)spacing;


@end

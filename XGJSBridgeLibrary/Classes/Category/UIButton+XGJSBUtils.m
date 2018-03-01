//
//  UIButton+XGJSBUtils.m
//  Pods
//
//  Created by ZJ-Jie on 2017/7/5.
//
//

#import "UIButton+XGJSBUtils.h"
#import "UIView+XGJSBTools.h"
#import "XGJSBridgeMacro.h"

@implementation UIButton (XGJSBUtils)

- (void)xgjsb_adpetiPhoneXBottom {
    
    if (XGJSB_iPhoneX) {
        self.height = self.height + XGJSB_iPhoneXCustomBottomPadding;
        self.titleEdgeInsets = UIEdgeInsetsMake(-XGJSB_iPhoneXCustomBottomPadding/2, 0, 0, 0);
    }
}

- (void)xgjsb_setTitleAndImagePosition:(XGJSBButtonImagePosition)imagePosition spacing:(float)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(200.f, 56.f) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size;
    
    UIEdgeInsets titleEdgeInsets;
    UIEdgeInsets imageEdgeInsets;
    switch (imagePosition) {
        case XGJSBButtonImagePositionLeft:
        {
            titleEdgeInsets = UIEdgeInsetsMake(0.f, spacing/2.f, 0.f, 0.f);
            imageEdgeInsets = UIEdgeInsetsMake(0.f, - spacing/2.f, 0.f, 0.f);
        }
            break;
        case XGJSBButtonImagePositionRight:
        {
            titleEdgeInsets = UIEdgeInsetsMake(0.f, -(imageSize.width +spacing/2.f), 0.f, imageSize.width);
            imageEdgeInsets = UIEdgeInsetsMake(0.f, titleSize.width + spacing/2.f, 0.f, -(titleSize.width));
        }
            break;
        case XGJSBButtonImagePositionTop:
        {
            CGFloat imageOffsetX = (imageSize.width+titleSize.width)/2.f - imageSize.width/2.f; //image中心移动的x距离
            CGFloat imageOffsetY = imageSize.height/2.f; //image中心移动的y距离
            CGFloat labelOffsetX = (imageSize.width + titleSize.width /2.f) - (imageSize.width + titleSize.width)/2.f; //label中心移动的x距离
            CGFloat labelOffsetY = titleSize.height/2.f; //label中心移动的y距离
            
            CGFloat topOffset =  (self.bounds.size.height - titleSize.height - imageSize.height - spacing) / 2;
            
            titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY + spacing/2 + topOffset, -labelOffsetX, -labelOffsetY, labelOffsetX);
            imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY - spacing/2 + topOffset, imageOffsetX, imageOffsetY, -imageOffsetX);
        }
            break;
        case XGJSBButtonImagePositionBottom:
        {
            CGFloat imageOffsetX = (imageSize.width+titleSize.width)/2.f - imageSize.width/2.f; //image中心移动的x距离
            CGFloat imageOffsetY = imageSize.height/2.f; //image中心移动的y距离
            CGFloat labelOffsetX = (imageSize.width + titleSize.width /2.f) - (imageSize.width + titleSize.width)/2.f; //label中心移动的x距离
            CGFloat labelOffsetY = titleSize.height/2.f; //label中心移动的y距离
            
            CGFloat topOffset =  (self.bounds.size.height - titleSize.height - imageSize.height - spacing) / 2;
            
            titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY - spacing/2 - topOffset, -labelOffsetX, labelOffsetY, labelOffsetX);
            imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY + spacing/2 - topOffset, imageOffsetX, -imageOffsetY, -imageOffsetX);
        }
            break;
        default:
        {
            titleEdgeInsets = UIEdgeInsetsMake(0.f, spacing/2.f, 0.f, 0.f);
            imageEdgeInsets = UIEdgeInsetsMake(0.f, - spacing/2.f, 0.f, 0.f);
        }
            break;
    }
    
    self.titleEdgeInsets = titleEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end

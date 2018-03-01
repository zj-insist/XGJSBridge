//
//  XGJSBridgeMacro.h
//  Pods
//
//  Created by ZJ-Jie on 2017/7/4.
//
//

#ifndef XGJSBridgeMacro_h
#define XGJSBridgeMacro_h

// RGB颜色
#define XGJSB_RGBCOLOR(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define XGJSB_RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define XGJSB_HEXRGBCOLOR(h)      XGJSB_RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define XGJSB_HEXRGBACOLOR(h,a)   XGJSB_RGBACOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)

//屏幕尺寸
#define XGJSB_Screen_Bounds [UIScreen mainScreen].bounds
#define XGJSB_Screen_Height [UIScreen mainScreen].bounds.size.height
#define XGJSB_Screen_Width [UIScreen mainScreen].bounds.size.width
#define XGJSB_Screen_Scale [UIScreen mainScreen].scale

//常用间隔
#define XGJSB_PaddingLeftWidth 15.0
#define XGJSB_PaddingRightWidth 15.0

//屏幕相关
#define XGJSB_KeyWindow [UIApplication sharedApplication].keyWindow

//系统相关
#define XGJSB_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define XGJSB_iPhoneXCustomBottomPadding 34

#endif /* XGJSBridgeMacro_h */

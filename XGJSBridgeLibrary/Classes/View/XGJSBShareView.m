//
//  XGJSBShareView.m
//  XGJSBridgeLibrary
//
//  Created by ZJ-Jie on 2017/7/4.
//  Copyright © 2017年 zj_lostself@163.com. All rights reserved.
//

#import "XGJSBShareView.h"
#import "XGJSBridgeMacro.h"
#import "UIButton+XGJSBUtils.h"
#import "XGJSBShareModel.h"
#import "UIView+XGJSBTools.h"


@implementation UIImage(Extra)

+ (UIImage *)createImageWithColor:(UIColor *)color {
    return [self createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

static CGFloat const kButtonImageWidth = 55;
static CGFloat const kTitleHeight = 20;
static CGFloat const kSpecing = 8;

@interface XGJSBSHareButton : UIButton

@end

@implementation XGJSBSHareButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGFloat imageW = kButtonImageWidth;
    CGFloat imageH = kButtonImageWidth;
    CGFloat imageY = (contentRect.size.height - kSpecing - kTitleHeight - kButtonImageWidth) / 2.f;
    CGFloat imageX = (contentRect.size.width - imageW) / 2.f;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = kTitleHeight;
    CGFloat titleX = 0;
    CGFloat titleY = (contentRect.size.height - kSpecing - kTitleHeight - kButtonImageWidth) / 2.f + kSpecing + kButtonImageWidth;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

static NSInteger const kScreenNum = 4;

@interface XGJSBShareView()

@property(nonatomic, strong) NSMutableArray<XGJSBShareModel *> *datas;
@property(nonatomic, strong) UIButton *cancelBtn;
//@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIScrollView *btnsBackView;
@property(nonatomic, strong) NSMutableArray<UIButton *> *shareBtns;
@property(nonatomic, strong) UIView *shareView;

@property(nonatomic, assign) NSInteger screenNum;

@end

@implementation XGJSBShareView

+ (instancetype)createShareAlertWithData:(NSMutableArray *)datas {
    return [XGJSBShareView createShareAlertWithScreenNum:kScreenNum data:datas];
}

+ (instancetype)createShareAlertWithScreenNum:(NSInteger)num data:(NSMutableArray *)datas {
    XGJSBShareView *shareView = [XGJSBShareView new];
    shareView.screenNum = num;
    shareView.datas = datas;
    [shareView setupBtns];
    return shareView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = XGJSB_KeyWindow.bounds;
        [self setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.6f]];
        [self setupSubViews];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.shareView.layer convertPoint:point fromLayer:self.layer];
    if (![self.shareView.layer containsPoint:point]) {
        [self handleCancelEvent:nil];
    }
}

- (void)setupSubViews {
    [self shareView];
//    [self.titleLabel setText:@"请选择分享方式"];
    [self cancelBtn];
    [self btnsBackView];
    [self.cancelBtn xgjsb_adpetiPhoneXBottom];
    self.cancelBtn.top = self.btnsBackView.bottom;
}

- (void)setupBtns {
    if (self.shareBtns.count > 0) {
        for (XGJSBSHareButton *obj in self.shareBtns) {
            [obj removeFromSuperview];
        }
        [self.shareBtns removeAllObjects];
    }
    CGFloat btnWidth = XGJSB_Screen_Width / MIN(self.datas.count, self.screenNum);
    if (self.datas.count > self.screenNum) {
        self.btnsBackView.contentSize = CGSizeMake(self.datas.count * btnWidth, 130);
    } else {
        self.btnsBackView.contentSize = CGSizeMake(XGJSB_Screen_Width, 130);
    }
    [self.datas enumerateObjectsUsingBlock:^(XGJSBShareModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XGJSBSHareButton *btn = [[XGJSBSHareButton alloc] initWithFrame:CGRectMake(idx * btnWidth, 0, btnWidth, 130)];
        [btn setTitleColor:XGJSB_HEXRGBCOLOR(0x333333) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setTitle:obj.shareTitle forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:obj.imageName] forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:self action:@selector(handleShareBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.shareBtns addObject:btn];
        [self.btnsBackView addSubview:btn];
    }];
}

- (void)handleShareBtnEvent:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(xgjsb_handleShareButtonWithIndex:)]) {
        [self.delegate xgjsb_handleShareButtonWithIndex:btn.tag];
    }
    [self handleCancelEvent:nil];
}

- (NSMutableArray<UIButton *> *)shareBtns {
    if (!_shareBtns) {
        _shareBtns = [NSMutableArray array];
    }
    return _shareBtns;
}

- (UIView *)shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, XGJSB_Screen_Height + [XGJSBShareView shareViewDefaultHeight], XGJSB_Screen_Width, [XGJSBShareView shareViewDefaultHeight])];
        [_shareView setBackgroundColor:XGJSB_HEXRGBCOLOR(0xf4f4f4)];
        [self addSubview:_shareView];
    }
    return _shareView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.shareView.bounds.size.height - 45, XGJSB_Screen_Width, 45)];
        [_cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_cancelBtn setTitleColor:XGJSB_HEXRGBCOLOR(0x333333) forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(handleCancelEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XGJSB_Screen_Width, .5)];
        [lineView setBackgroundColor:XGJSB_HEXRGBCOLOR(0xEBEBEB)];
        [_cancelBtn addSubview:lineView];
        
        [self.shareView addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIScrollView *)btnsBackView {
    if (!_btnsBackView) {
        _btnsBackView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, XGJSB_Screen_Width, 130)];
        _btnsBackView.contentSize = CGSizeMake(XGJSB_Screen_Width, 130);
        _btnsBackView.showsHorizontalScrollIndicator = NO;
        [_btnsBackView setBackgroundColor:[UIColor whiteColor]];
        [self.shareView addSubview:_btnsBackView];
    }
    return _btnsBackView;
}

- (void)show {
    [XGJSB_KeyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.frame = ({
            CGRect frame = self.shareView.frame;
            frame.origin.y = XGJSB_Screen_Height - [XGJSBShareView shareViewDefaultHeight];
            frame;
        });
    } completion:nil];
}

- (void)showInVC:(__kindof UIViewController *)vc {
    [vc.view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.frame = ({
            CGRect frame = self.shareView.frame;
            frame.origin.y = XGJSB_Screen_Height - [XGJSBShareView shareViewDefaultHeight];
            frame;
        });
        
    } completion:nil];
}

- (void)handleCancelEvent:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.frame = ({
            CGRect frame = self.shareView.frame;
            frame.origin.y = XGJSB_Screen_Height;
            frame;
        });
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (CGFloat)shareViewDefaultHeight {
    CGFloat safeAreaSapcing = 0;
    if (XGJSB_iPhoneX) {
        safeAreaSapcing = XGJSB_iPhoneXCustomBottomPadding;
    }
    return 45 + 130 + safeAreaSapcing;
}

@end

//
//  CustomDrogView.m
//  GestureRecognizerTest
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomDrogView.h"
#define ratio 2
@interface CustomDrogView()

@property (nonatomic, strong) UIImageView *firstImgV;//第一张图片
@property (nonatomic, strong) UIView *miniView;
@property (nonatomic, strong) UIImageView *miniImg;
@property (nonatomic, strong) UIView *miniIndicator;
@property (nonatomic, strong) UISlider *silder;

@end
@implementation CustomDrogView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubUI];
    }
    return self;
}

- (void)addSubUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //设置内容大小
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*1.001, _scrollView.frame.size.height*1.001);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.bouncesZoom = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 5;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired=2;
    [_scrollView addGestureRecognizer:tapGesture];
    [self addSubview:_scrollView];
    _firstImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _firstImgV.backgroundColor = [UIColor whiteColor];
    _firstImgV.image = [UIImage imageNamed:@"huahuagongzhu12.jpg"];
    [_scrollView addSubview:_firstImgV];
    
    _miniView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, _scrollView.frame.size.width / ratio, _scrollView.frame.size.height / ratio)];
    _miniView.backgroundColor = [UIColor redColor];
    _miniView.clipsToBounds = YES;
    [self addSubview:_miniView];
    _miniImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _miniView.frame.size.width, _miniView.frame.size.height)];
    _miniImg.image = [UIImage imageNamed:@"huahuagongzhu12.jpg"];
    [_miniView addSubview:_miniImg];
    _miniIndicator = [[UIView alloc]initWithFrame:CGRectMake(
                                                              self.scrollView.contentOffset.x/ratio/self.scrollView.zoomScale,
                                                              self.scrollView.contentOffset.y/ratio/self.scrollView.zoomScale,
                                                              _miniView.frame.size.width/self.scrollView.zoomScale,
                                                              _miniView.frame.size.height/self.scrollView.zoomScale)];
    _miniIndicator.layer.borderWidth = 1.0;
    _miniIndicator.layer.borderColor = [UIColor blueColor].CGColor;
    _miniIndicator.backgroundColor = [UIColor clearColor];
    [_miniView addSubview:_miniIndicator];
    _silder = [[UISlider alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_miniView.frame), 200, 50)];
    _silder.maximumValue = _scrollView.maximumZoomScale;
    _silder.minimumValue = _scrollView.minimumZoomScale;
    _silder.value = self.scrollView.zoomScale;
    [_silder setContinuous:YES];
    _silder.thumbTintColor = [UIColor blueColor];
    _silder.maximumTrackTintColor = [UIColor grayColor];
    _silder.minimumTrackTintColor = [UIColor redColor];
    [_silder addTarget:self action:@selector(silderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_silder];
}

- (void)silderValueChanged:(UISlider *)silder{
    [_scrollView setZoomScale:silder.value animated:YES];
}

//放大缩小
-(void)handleTapGesture:(UIGestureRecognizer*)sender
{
    if(_scrollView.zoomScale > 1.0){
        [_scrollView setZoomScale:1.0 animated:YES];
    }else{
        [_scrollView setZoomScale:5.0 animated:YES];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        return _firstImgV;
    }
    return nil;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    _miniIndicator.frame = CGRectMake(_miniIndicator.frame.origin.x
                                       , _miniIndicator.frame.origin.y,
                                       _miniView.frame.size.width/self.scrollView.zoomScale,
                                       _miniView.frame.size.height/self.scrollView.zoomScale);
    _silder.value = scrollView.zoomScale;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _miniIndicator.frame =
    CGRectMake(self.scrollView.contentOffset.x/ratio/self.scrollView.zoomScale,
               self.scrollView.contentOffset.y/ratio/self.scrollView.zoomScale,
               _miniIndicator.frame.size.width,
               _miniIndicator.frame.size.height);
    if (scrollView == _scrollView) {
//        _sccondScrollview.contentOffset = scrollView.contentOffset;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

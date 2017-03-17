//
//  ViewController.m
//  ImagePixel
//
//  Created by houli on 2017/3/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)


@interface ViewController ()
{

    CGFloat _bottomHeight;
    CGFloat _bottomWidth;
    CGFloat _x;
    CGFloat _y;
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    NSMutableArray *pixArray;
}
@property(nonatomic,strong) NSMutableArray *columnArray;/**< 存放获取图片像素点的列数组*/
@property(nonatomic,strong) NSMutableArray *tmpArray;/**< 存放获取图片像素点的列数组*/
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pixArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    //图片高度
    UIImage *_img = [UIImage imageNamed:@"match_point_left"];
    float _biLv=(ScreenHeight/568.0);
    _bottomHeight = _img.size.height;
    _bottomWidth = _img.size.width;
    _y = ScreenHeight - 100*_biLv + 10;
    _x = 10;
    
    //left
    UIImageView * _view = [[UIImageView alloc]initWithFrame:CGRectMake(_x,  _y , _img.size.width, _img.size.height)];
    
    UIImage *image = [Utils ct_imageFromImage:self.bgImage.image inRect:CGRectMake(_x, _y, _bottomWidth, _bottomHeight)];
    [Utils getPix:image andPixArray:pixArray];
    UIImage *resltImag = [Utils getResultImageWit:pixArray andBeginImage:_img];
    
    _view.image = resltImag;
    

    [self.view addSubview:_view];
   
}




@end

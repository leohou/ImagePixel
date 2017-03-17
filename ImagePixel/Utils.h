//
//  Utils.h
//  ImagePixel
//
//  Created by houli on 2017/3/17.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Utils : NSObject


+(CGDataProviderRef)getPix:(UIImage *)image;

//根据原图 截取部分图片并生成新图片
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect;

+(UIImage *)getResultImage:(CGDataProviderRef)ref andBeginImage:(UIImage *)image;

//根据原图截取的部分图片获取所有的像素点
+(void)getPix:(UIImage *)image  andPixArray:(NSMutableArray *)array;

//根据反色像素点 填充需要反色的图片
+(UIImage *)getResultImageWit:(NSMutableArray *)resultPixArray andBeginImage:(UIImage *)image;

//根据color 获取rgb 值
- (void)rgb:(UIColor *)_color;
@end

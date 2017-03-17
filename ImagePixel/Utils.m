//
//  Utils.m
//  ImagePixel
//
//  Created by houli on 2017/3/17.
//  Copyright © 2017年 com. All rights reserved.
//

#import "Utils.h"
#import "Color.h"


@implementation Utils


+(CGDataProviderRef)getPix:(UIImage *)image
{
    CGImageRef  imageRef;
    imageRef = image.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている  构成像素的RGB各要素在几位构成
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか  像素的整体是几位？
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか 图像的横1线条的数据，在几打工构成的
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間   图像的颜色空间
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報  图像的Bitmap信息
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか 图像是象素间的补完吗？
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか  根据显示装置来补正吗？
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する  取得图像的数据供应商
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得  数据来自服务提供商的bitmap生图像数据
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理  一像素一像素的图像
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす   RGBA的4个值，拥有着，所以1像素每* 4错
            
            // RGB値を取得 取得RGB值
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            *(tmp + 0) = 255 - red;
            *(tmp + 1) = 255 - green;
            *(tmp + 2) = 255 - blue;
            
            
        }
    }
    
    // 効果を与えたデータ生成  产生效应的数据产生
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成  产生效果的数据供应商
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    return effectedDataProvider;
}

/*
 *  describtion 根据原图 截取部分图片并生成新图片
 *  image  原图
 *  rect   需要生成图片的frame
 **/
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x,y=rect.origin.y,w=rect.size.width,h=rect.size.height;
    CGRect dianRect = CGRectMake(x, y, w*scale, h*scale);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

/*
 *  describtion 根据原图 截取部分图片并生成新图片
 *  image  需要反色的图片
 *  rect   需要生成图片的frame
 **/

+(UIImage *)getResultImage:(CGDataProviderRef)ref andBeginImage:(UIImage *)image
{
    CGImageRef  imageRef;
    imageRef = image.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている  构成像素的RGB各要素在几位构成
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか  像素的整体是几位？
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか 图像的横1线条的数据，在几打工构成的
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間   图像的颜色空间
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報  图像的Bitmap信息
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか 图像是象素间的补完吗？
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか  根据显示装置来补正吗？
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する  取得图像的数据供应商
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得  数据来自服务提供商的bitmap生图像数据
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);

    
    // 画像を生成   图像生成
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, ref,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    // データの解放
    CGImageRelease(effectedCgImage);
//    CFRelease(effectedDataProvider);
//    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

/*
 *  describtion 根据原图截取的部分图片获取所有的像素点
 *  image  原图截取的部分图片（需反色的对比图片）
 *  array  存放反色的数组
 **/

+(void)getPix:(UIImage *)image andPixArray:(NSMutableArray *)array
{
    CGImageRef  imageRef;
    imageRef = image.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている  构成像素的RGB各要素在几位构成
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか  像素的整体是几位？
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか 图像的横1线条的数据，在几打工构成的
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間   图像的颜色空间
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報  图像的Bitmap信息
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか 图像是象素间的补完吗？
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか  根据显示装置来补正吗？
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する  取得图像的数据供应商
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得  数据来自服务提供商的bitmap生图像数据
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理  一像素一像素的图像
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす   RGBA的4个值，拥有着，所以1像素每* 4错
            
            // RGB値を取得 取得RGB值
            UInt8 red,green,blue,alpa;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            alpa = *(tmp + 3);
            
//            *(tmp + 0) = 255 - red;
//            *(tmp + 1) = 255 - green;
//            *(tmp + 2) = 255 - blue;
            Color *color = [[Color alloc] init];
            color.r = 255 - red;
            color.g = 255 - green;
            color.b = 255 - blue;
            color.a = alpa;
            
            [array addObject:color];
            
        }
    }
    
    // 効果を与えたデータ生成  产生效应的数据产生
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成  产生效果的数据供应商
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
}

/*
 *  describtion 根据反色像素点 填充需要反色的图片
 *  image  需要反色的图片
 *  resultPixArray   存放反色像素点的数组
 **/

+(UIImage *)getResultImageWit:(NSMutableArray *)resultPixArray andBeginImage:(UIImage *)image
{
    CGImageRef  imageRef;
    imageRef = image.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている  构成像素的RGB各要素在几位构成
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか  像素的整体是几位？
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか 图像的横1线条的数据，在几打工构成的
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間   图像的颜色空间
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報  图像的Bitmap信息
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか 图像是象素间的补完吗？
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか  根据显示装置来补正吗？
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する  取得图像的数据供应商
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得  数据来自服务提供商的bitmap生图像数据
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理  一像素一像素的图像
    NSUInteger  x, y, z;
                       z = 0;
    for (y = 0; y < height ; y++) {
        for (x = 0; x < width ; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす   RGBA的4个值，拥有着，所以1像素每* 4错
            Color *color = [resultPixArray objectAtIndex:z];
            
            // RGB値を取得 取得RGB值
            UInt8 red,green,blue,alpa;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            alpa = *(tmp + 3);
            
            if(alpa != 0){
                *(tmp + 0) = color.r;
                *(tmp + 1) = color.g;
                *(tmp + 2) = color.b;
            }
            
            z++;
        }
    }
    
    // 効果を与えたデータ生成  产生效应的数据产生
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成  产生效果的数据供应商
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    // 画像を生成   图像生成
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    // データの解放
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    return effectedImage;
}
-(void)rgb:(UIColor *)_color
{
    CGFloat R, G, B;
    
    CGColorRef color = [_color CGColor];
    size_t numComponents = CGColorGetNumberOfComponents(color);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        R = components[0];
        G = components[1];
        B = components[2];
        
        CGFloat r = R*255;
        CGFloat g = G*255;
        CGFloat b = B*255;
        Color *color = [[Color alloc] init];
        color.r = r;
        color.g = g;
        color.b = b;
    }
    
}

@end

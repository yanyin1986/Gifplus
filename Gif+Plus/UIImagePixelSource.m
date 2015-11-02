//
//  UIImagePixelSource.m
//  Gif+Plus
//
//  Created by Leon.yan on 11/2/15.
//  Copyright © 2015 tinycomic. All rights reserved.
//

#import "UIImagePixelSource.h"

@interface UIImagePixelSource()
{
    ANImageBitmapRep *_imageRep;
}
@end

@implementation UIImagePixelSource

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _imageRep = [[ANImageBitmapRep alloc] initWithImage:image];
    }
    
    return self;
}

+ (UIImagePixelSource *)pixelSourceWithImage:(UIImage *)image
{
    return [[UIImagePixelSource alloc] initWithImage:image];
}

- (NSUInteger)pixelsWide {
    return _imageRep.bitmapSize.x;
}

- (NSUInteger)pixelsHigh {
    return _imageRep.bitmapSize.y;
}

- (void)getPixel:(NSUInteger *)pixel atX:(NSInteger)x y:(NSInteger)y
{
    BMPixel bmPixel = [_imageRep getPixelAtPoint:BMPointMake(x, y)];
    pixel[0] = (NSUInteger) round(bmPixel.red * 255.0);
    pixel[1] = (NSUInteger) round(bmPixel.green * 255.0);
    pixel[2] = (NSUInteger) round(bmPixel.blue * 255.0);
    pixel[3] = (NSUInteger) round(bmPixel.alpha * 255.0);
}

- (BOOL)hasTransparency {
    return YES;
}

@end

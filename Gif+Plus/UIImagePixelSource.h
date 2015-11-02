//
//  UIImagePixelSource.h
//  Gif+Plus
//
//  Created by Leon.yan on 11/2/15.
//  Copyright © 2015 tinycomic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANGifImageFramePixelSource.h"
#import "ANImageBitmapRep.h"

@interface UIImagePixelSource : NSObject<ANGifImageFramePixelSource>

- (instancetype)initWithImage:(UIImage *)image;
+ (UIImagePixelSource *)pixelSourceWithImage:(UIImage *)image;

@end

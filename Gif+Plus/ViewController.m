//
//  ViewController.m
//  Gif+Plus
//
//  Created by Leon.yan on 11/2/15.
//  Copyright © 2015 tinycomic. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "ANGifEncoder.h"
#import "ANGifNetscapeAppExtension.h"
#import "UIImagePixelSource.h"
#import "ANCutColorTable.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"IMG_0638" withExtension:@"m4v"];
    AVAsset *asset = [AVURLAsset assetWithURL:fileURL];
    AVAssetTrack *videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] lastObject];
    
    CGSize size = videoTrack.naturalSize;
    CMTime duration = videoTrack.timeRange.duration;
    CMTime frameDuration = videoTrack.minFrameDuration;
    
    
    CGSize sizeLimit = AVMakeRectWithAspectRatioInsideRect(size, CGRectMake(0, 0, 640, 640)).size;
    
    Float64 durationSec = CMTimeGetSeconds(duration);
    Float64 frameCount = floor(3.0 / 0.22);
    
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.requestedTimeToleranceBefore = frameDuration;
    generator.requestedTimeToleranceAfter = frameDuration;
    generator.maximumSize = sizeLimit;
    
    NSMutableArray *array = [NSMutableArray array];
    CMTime startTime = kCMTimeZero;
    CMTime actucalTime;
    NSError *error;
    for (int i = 0; i < frameCount; i++) {
        UIImage *image = [UIImage imageWithCGImage:[generator copyCGImageAtTime:startTime actualTime:&actucalTime error:&error]];
        [array addObject:image];
        startTime = CMTimeAdd(startTime, CMTimeMakeWithSeconds(0.22, 600));
    }
    
    ANGifEncoder *encoder = [[ANGifEncoder alloc] initWithOutputFile:@"/Users/leonyan/Desktop/1.gif" size:sizeLimit globalColorTable:nil];
    [encoder addApplicationExtension:[[ANGifNetscapeAppExtension alloc] initWithRepeatCount:0xffff]];
    int i = 0;
    for (UIImage *image in array) {
        UIImagePixelSource *pixelSource = [UIImagePixelSource pixelSourceWithImage:image];
        ANCutColorTable *colorTable = [[ANCutColorTable alloc] initWithTransparentFirst:NO pixelSource:pixelSource];
        ANGifImageFrame *frame = [[ANGifImageFrame alloc] initWithPixelSource:pixelSource colorTable:colorTable delayTime:0.22];
        [encoder addImageFrame:frame];
        NSLog(@"finish frame [ %d ] ", i);
        i++;
    }
    
    [encoder closeFile];
    NSLog(@"Finished!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  FaceDetector.m
//  opencv.facedetect
//
//  Created by hiroyukky on 6/13/15.
//  Copyright (c) 2015 hiroyukky. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "opencv.facedetect-Bridging-Header.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@interface FaceDetector()
{
    cv::CascadeClassifier cascade;
}
@end

@implementation FaceDetector: NSObject

-(id)init{
    self = [super init];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path   = [bundle pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    std::string cascadeName = (char *)[path UTF8String];
    if(!cascade.load(cascadeName)){
        return nil;
    }
    return self;
}

-(UIImage *) detectFace:(UIImage *) image{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;

    cv::Mat mat(rows, cols, CV_8UC4);

    CGContextRef contextRef = CGBitmapContextCreate(mat.data, cols, rows, 8, mat.step[0], colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);

    std::vector<cv::Rect> faces;
    cascade.detectMultiScale(mat, faces, 1.1, 2, CV_HAAR_SCALE_IMAGE, cv::Size(10, 10));

    std::vector<cv::Rect>::const_iterator r = faces.begin();
    for(; r!=faces.end();++r){
        cv::Point center;
        int radius;
        center.x = cv::saturate_cast<int>(r->x + r->width*0.5);
        center.y = cv::saturate_cast<int>(r->y + r->height*0.5);
        radius = cv::saturate_cast<int>(r->width * 0.2 + r->height * 0.2);
        cv::circle(mat, center, radius, cv::Scalar(80, 80, 255), 3, 8, 0);
    }
    UIImage *resultImage = MatToUIImage(mat);
    return resultImage;
}
@end
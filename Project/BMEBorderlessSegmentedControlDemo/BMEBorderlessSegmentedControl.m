//
//  BMEBorderlessSegmentedControl.m
//  
//
//  Created by Brandon Evans on 2/10/2014.
//  Copyright (c) 2014 Brandon Evans. All rights reserved.
//

#import "BMEBorderlessSegmentedControl.h"
#import "NSImage+DrawAsTemplate.h"

@implementation BMEBorderlessSegmentedControl

- (void)drawRect:(NSRect)rect {
    CGFloat segmentWidth = rect.size.width / [self segmentCount];
    CGFloat segmentHeight = 19.0;
    NSRect segmentRect = NSMakeRect(0, 0, segmentWidth, segmentHeight);

    for (NSInteger segmentIndex = 0; segmentIndex < [self segmentCount]; segmentIndex += 1) {
        [self drawSegmentAtIndex:segmentIndex inFrame:segmentRect selected:(segmentIndex == self.selectedSegment)];
        segmentRect.origin.x += segmentWidth;
    }
}

- (void)drawSegmentAtIndex:(NSInteger)segmentIndex inFrame:(NSRect)frame selected:(BOOL)selected {
    CGFloat alpha;

    if ([[self window] isKeyWindow]) {
        alpha = 0.5;
    }
    else {
        alpha = 0.2;
    }

    NSImage *segmentImage = [self imageForSegment:segmentIndex];
    if (segmentImage) {
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [self drawCenteredImage:segmentImage inFrame:frame alpha:alpha selected:selected];
    }
}

- (void)drawCenteredImage:(NSImage*)image inFrame:(NSRect)frame alpha:(CGFloat)alpha selected:(BOOL)selected {
    CGSize imageSize = [image size];
    CGFloat x = frame.origin.x + (frame.size.width - imageSize.width) / 2.0;
    CGFloat y = frame.origin.y + (frame.size.height - imageSize.height) / 2.0;
    CGRect rect = CGRectIntegral(NSMakeRect(x, y + 1, imageSize.width, imageSize.height));
    [image drawAsTemplateInRect:rect highlighted:selected];
}

@end
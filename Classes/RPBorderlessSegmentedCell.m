//
//  RPBorderlessSegmentedCell.m
//  RPBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/11/2014.
//  Copyright (c) 2014 Robots and Pencils. All rights reserved.
//

#import "RPBorderlessSegmentedCell.h"
#import "NSImage+DrawAsTemplate.h"

@implementation RPBorderlessSegmentedCell

#pragma mark - NSSegmentedCell

- (void)drawSegment:(NSInteger)segment inFrame:(NSRect)frame withView:(NSView *)controlView {
    CGFloat alpha;

    if ([[controlView window] isKeyWindow]) {
        alpha = 0.5;
    }
    else {
        alpha = 0.2;
    }

    NSImage *image = [self imageForSegment:segment];
    if (image) {
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [self drawCenteredImage:image inFrame:frame alpha:alpha selected:[self isSelectedForSegment:segment] enabled:[(NSControl *)controlView isEnabled]];
    }
}

#pragma mark - Private

- (void)drawCenteredImage:(NSImage*)image inFrame:(NSRect)frame alpha:(CGFloat)alpha selected:(BOOL)selected enabled:(BOOL)enabled {
    double sourceRatio = image.size.width / image.size.height;
    double targetRatio = NSWidth(frame) / NSHeight(frame);
    
    NSSize finalSize;
    if (sourceRatio > targetRatio) {
        finalSize = NSMakeSize(NSWidth(frame), NSWidth(frame) / sourceRatio);
    }
    else {
        finalSize = NSMakeSize(NSHeight(frame) * sourceRatio, NSHeight(frame));
    }
    
    CGFloat x = frame.origin.x + (frame.size.width - finalSize.width) / 2.0;
    CGFloat y = frame.origin.y + (frame.size.height - finalSize.height) / 2.0;
    
    CGRect rect = CGRectIntegral(NSMakeRect(x, y + 1, finalSize.width, finalSize.height));
    [image rp_drawAsTemplateInRect:rect inView:self.controlView highlighted:selected enabled:enabled];
}

@end

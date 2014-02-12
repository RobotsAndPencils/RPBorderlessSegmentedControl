//
//  BMEBorderlessSegmentedCell.m
//
//
//  Created by Brandon Evans on 2/11/2014.
//
//

#import "BMEBorderlessSegmentedCell.h"
#import "NSImage+DrawAsTemplate.h"

@implementation BMEBorderlessSegmentedCell

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
        [self drawCenteredImage:image inFrame:frame alpha:alpha selected:[self isSelectedForSegment:segment]];
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

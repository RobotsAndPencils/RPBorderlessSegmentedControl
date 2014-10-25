//
//  NSImage+DrawAsTemplate.m
//  RPBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/10/2014.
//  Copyright (c) 2014 Robots and Pencils. All rights reserved.
//

#import "NSImage+DrawAsTemplate.h"

@implementation NSImage (DrawAsTemplate)

- (void)rp_drawAsTemplateInRect:(NSRect)rect inView:(NSView *)view highlighted:(BOOL)highlighted enabled:(BOOL)enabled {
    CGFloat dropShadowOffsetY = -1.0;
    CGFloat innerShadowBlurRadius = 1.0;
    
    NSGraphicsContext *graphicsContext = [NSGraphicsContext currentContext];
    CGContextRef context = [graphicsContext graphicsPort];
    
    [graphicsContext saveGraphicsState];
    
    CGRect deviceRect = CGContextConvertRectToDeviceSpace(context, rect);
    CGFloat scale = CGRectGetHeight(deviceRect) / CGRectGetHeight(rect);
    
    if ([graphicsContext isFlipped]) {
        CGContextTranslateCTM(context, 0.0f, CGRectGetHeight(view.frame));
        CGContextScaleCTM(context, 1.0f, -1.0f);
    }

    // Create mask image
    NSRect maskRect = rect;
    CGImageRef maskImage = [self CGImageForProposedRect:&maskRect context:graphicsContext hints:nil];
    
    // Draw image and white drop shadow
    CGContextSetShadowWithColor(context, CGSizeMake(0, dropShadowOffsetY), 0, CGColorGetConstantColor(kCGColorWhite));
    [self drawInRect:maskRect fromRect:NSMakeRect(0, 0, self.size.width, self.size.height) operation:NSCompositeSourceOver fraction:0.5];

    // Clip drawing to mask
    CGContextClipToMask(context, NSRectToCGRect(maskRect), maskImage);

    // Draw gradient
    NSColor *startColor;
    NSColor *endColor;
    if (highlighted) {
        startColor = [NSColor colorWithCalibratedRed:0.0 green:0.55 blue:0.98 alpha:1.0];
        endColor = [NSColor colorWithCalibratedRed:0.0 green:0.15 blue:0.75 alpha:1.0];
    }
    else {
        startColor = [NSColor colorWithDeviceWhite:0.33 alpha:1.0];
        endColor = [NSColor colorWithDeviceWhite:0.46 alpha:1.0];
    }
    if (!enabled) {
        startColor = [startColor colorWithAlphaComponent:0.5];
        endColor = [endColor colorWithAlphaComponent:0.5];
    }
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
    [gradient drawInRect:maskRect angle:90.0];

    // Draw inner shadow with inverted mask
    CGContextSetShadowWithColor(context, CGSizeMake(0, -1), innerShadowBlurRadius, [[NSColor colorWithCalibratedWhite:0.1 alpha:0.75] CGColor]);
    CGRect cgRect = CGRectMake( 0, 0, maskRect.size.width * scale, maskRect.size.height * scale);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef maskContext = CGBitmapContextCreate(NULL, deviceRect.size.width, deviceRect.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(maskContext, kCGBlendModeXOR);
    CGContextDrawImage(maskContext, cgRect, maskImage);
    CGContextSetRGBFillColor(maskContext, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(maskContext, cgRect);
    CGImageRef invertedMaskImage = CGBitmapContextCreateImage(maskContext);
    
    CGContextDrawImage(context, maskRect, invertedMaskImage);

    CGImageRelease(invertedMaskImage);
    CGContextRelease(maskContext);
    
    [graphicsContext restoreGraphicsState];
}

@end

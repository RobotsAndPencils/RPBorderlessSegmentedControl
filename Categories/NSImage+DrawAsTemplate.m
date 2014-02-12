//
//  NSImage+DrawAsTemplate.m
//  BMEBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/10/2014.
//  Based on Ole Zorn's Stack Overflow response http://stackoverflow.com/a/7138497/1082395
//

#import "NSImage+DrawAsTemplate.h"

@implementation NSImage (DrawAsTemplate)

- (void)drawAsTemplateInRect:(NSRect)rect highlighted:(BOOL)highlighted {
    CGFloat dropShadowOffsetY = -1.0;
    CGFloat innerShadowBlurRadius = 1.0;

    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];

    //save the current graphics state
    CGContextSaveGState(context);

    //Create mask image:
    NSRect maskRect = rect;
    CGImageRef maskImage = [self CGImageForProposedRect:&maskRect context:[NSGraphicsContext currentContext] hints:nil];

    //Draw image and white drop shadow:
    CGContextSetShadowWithColor(context, CGSizeMake(0, dropShadowOffsetY), 0, CGColorGetConstantColor(kCGColorWhite));
    [self drawInRect:maskRect fromRect:NSMakeRect(0, 0, self.size.width, self.size.height) operation:NSCompositeSourceOver fraction:0.5];

    //Clip drawing to mask:
    CGContextClipToMask(context, NSRectToCGRect(maskRect), maskImage);

    //Draw gradient:
    NSColor *startColor;
    NSColor *endColor;
    if (highlighted) {
        startColor = [NSColor colorWithCalibratedRed:0.0 green:0.15 blue:0.75 alpha:1.0];
        endColor = [NSColor colorWithCalibratedRed:0.0 green:0.55 blue:0.98 alpha:1.0];
    }
    else {
        startColor = [NSColor colorWithDeviceWhite:0.46 alpha:1.0];
        endColor = [NSColor colorWithDeviceWhite:0.33 alpha:1.0];
    }
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor endingColor:endColor];
    [gradient drawInRect:maskRect angle:90.0];

    //Draw inner shadow with inverted mask:
    CGContextSetShadowWithColor(context, CGSizeMake(0, -1), innerShadowBlurRadius, [[NSColor colorWithCalibratedWhite:0.1 alpha:0.75] CGColor]);
    CGRect cgRect = CGRectMake( 0, 0, maskRect.size.width, maskRect.size.height );
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef maskContext = CGBitmapContextCreate(NULL, CGImageGetWidth(maskImage), CGImageGetHeight(maskImage), 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(maskContext, kCGBlendModeXOR);
    CGContextDrawImage(maskContext, cgRect, maskImage);
    CGContextSetRGBFillColor(maskContext, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(maskContext, cgRect);
    CGImageRef invertedMaskImage = CGBitmapContextCreateImage(maskContext);
    CGContextDrawImage(context, maskRect, invertedMaskImage);
    CGImageRelease(invertedMaskImage);
    CGContextRelease(maskContext);

    //restore the graphics state
    CGContextRestoreGState(context);
}

@end

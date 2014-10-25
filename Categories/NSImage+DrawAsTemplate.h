//
//  NSImage+DrawAsTemplate.h
//  RPBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/10/2014.
//  Copyright (c) 2014 Robots and Pencils. All rights reserved.
//

@interface NSImage (DrawAsTemplate)

/**
 *  Draws the image as a template similar to the Xcode toolbar controls
 *  Based on Ole Zorn's Stack Overflow response http://stackoverflow.com/a/7138497/1082395
 *
 *  @param rect        The rect that the image will be drawn inside
 *  @param view        The view (usually the controlView) that the image will be drawn inside
 *  @param highlighted Whether the image should be drawn with a blue highlight
 *  @param enabled     Whether the image should be drawn with full opacity
 */
- (void)rp_drawAsTemplateInRect:(NSRect)rect inView:(NSView *)view highlighted:(BOOL)highlighted enabled:(BOOL)enabled;

@end

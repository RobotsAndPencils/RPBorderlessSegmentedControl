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
 *  @param rect        the rect that the image will be drawn inside
 *  @param view        the view (usually the controlView) that the image will be drawn inside
 *  @param highlighted whether the image should be drawn with a blue highlight
 *  @param enabled     whether the image should be drawn as if the control were enabled
 */
- (void)rp_drawAsTemplateInRect:(NSRect)rect inView:(NSView *)view highlighted:(BOOL)highlighted enabled:(BOOL)enabled;

@end

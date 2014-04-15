//
//  NSImage+DrawAsTemplate.h
//  RPBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/10/2014.
//  Copyright (c) 2014 Robots and Pencils. All rights reserved.
//

//  Based on Ole Zorn's Stack Overflow response http://stackoverflow.com/a/7138497/1082395

@interface NSImage (DrawAsTemplate)

- (void)drawAsTemplateInRect:(NSRect)rect highlighted:(BOOL)highlighted;

@end

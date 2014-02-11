//
//  NSImage+DrawAsTemplate.h
//  BMEBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/10/2014.
//  Based on Ole Zorn's Stack Overflow response http://stackoverflow.com/a/7138497/1082395
//

@interface NSImage (DrawAsTemplate)

- (void)drawAsTemplateInRect:(NSRect)rect highlighted:(BOOL)highlighted;

@end

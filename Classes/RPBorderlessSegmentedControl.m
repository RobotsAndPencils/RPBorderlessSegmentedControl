//
//  RPBorderlessSegmentedControl.m
//  RPBorderlessSegmentedControlDemo
//
//  Created by Brandon Evans on 2/10/2014.
//  Copyright (c) 2014 Robots and Pencils. All rights reserved.
//

#import "RPBorderlessSegmentedControl.h"
#import "RPBorderlessSegmentedCell.h"

@implementation RPBorderlessSegmentedControl

+ (Class)cellClass {
    return [RPBorderlessSegmentedCell class];
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setWantsLayer:YES];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (![aDecoder isKindOfClass:[NSKeyedUnarchiver class]]) {
		return [super initWithCoder:aDecoder];
    }

	NSKeyedUnarchiver *unarchiver = (NSKeyedUnarchiver *)aDecoder;
	Class oldClass = [[self superclass] cellClass];
	Class newClass = [[self class] cellClass];

	[unarchiver setClass:newClass forClassName:NSStringFromClass(oldClass)];
	self = [super initWithCoder:aDecoder];
	[unarchiver setClass:oldClass forClassName:NSStringFromClass(oldClass)];

	return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setWantsLayer:YES];
}

- (void)drawRect:(NSRect)rect {
    CGFloat segmentWidth = rect.size.width / [self segmentCount];
    CGFloat segmentHeight = rect.size.height - 1;
    NSRect segmentRect = NSMakeRect(0, 0, segmentWidth, segmentHeight);

    for (NSInteger segmentIndex = 0; segmentIndex < [self segmentCount]; segmentIndex += 1) {
        [(NSSegmentedCell *)self.cell drawSegment:segmentIndex inFrame:segmentRect withView:self];
        segmentRect.origin.x += segmentWidth;
    }
}

@end

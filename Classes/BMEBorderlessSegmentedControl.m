//
//  BMEBorderlessSegmentedControl.m
//
//
//  Created by Brandon Evans on 2/10/2014.
//  Copyright (c) 2014 Brandon Evans. All rights reserved.
//

#import "BMEBorderlessSegmentedControl.h"
#import "BMEBorderlessSegmentedCell.h"

@implementation BMEBorderlessSegmentedControl

+ (Class)cellClass {
    return [BMEBorderlessSegmentedCell class];
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

- (void)drawRect:(NSRect)rect {
    CGFloat segmentWidth = rect.size.width / [self segmentCount];
    CGFloat segmentHeight = 19.0;
    NSRect segmentRect = NSMakeRect(0, 0, segmentWidth, segmentHeight);

    for (NSInteger segmentIndex = 0; segmentIndex < [self segmentCount]; segmentIndex += 1) {
        [(NSSegmentedCell *)self.cell drawSegment:segmentIndex inFrame:segmentRect withView:self];
        segmentRect.origin.x += segmentWidth;
    }
}

@end
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

/**
 *  This override will replace the default cell class with the class returned by +[RPBorderlessSegmentedControl cellClass] defined above.
 */
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

/**
 *  The default implementation of -[NSControl drawRect:] will call -[self.cell drawWithFrame:inView] which draws the background and border and then calls into -[self drawInteriorWithFrame:inView:] for the contents. In this override we're just skipping the background and border drawing since all we want is the interior, or contents.
 */
- (void)drawRect:(NSRect)rect {
    [self.cell drawInteriorWithFrame:rect inView:self];
}

@end

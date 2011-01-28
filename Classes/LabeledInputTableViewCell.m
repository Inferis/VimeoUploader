//
//  LabeledInputTableViewCell.m
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 28/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import "LabeledInputTableViewCell.h"


@implementation LabeledInputTableViewCell

@synthesize field;

#pragma mark -
#pragma mark Overridden methods

- (BOOL)becomeFirstResponder {
	return [field becomeFirstResponder];
}

#pragma mark -
#pragma mark Custom methods

- (id)initWithReuseIdentifier:(NSString *)identifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		CGFloat width = self.contentView.bounds.size.width-16;
		field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 25)];
		field.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		field.clearsOnBeginEditing = NO;
		field.autocorrectionType = UITextAutocorrectionTypeNo;
		field.autocapitalizationType = UITextAutocapitalizationTypeSentences;
		field.returnKeyType = UIReturnKeyNext;
		field.clearButtonMode = UITextFieldViewModeWhileEditing;
		field.font = self.detailTextLabel.font;
		self.detailTextLabel.text = @"temp";
		[self.contentView addSubview:field];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGFloat width = self.contentView.bounds.size.width - 8 - self.detailTextLabel.frame.origin.x;
	field.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, width, self.detailTextLabel.frame.size.height);
	field.font = self.detailTextLabel.font;
	self.detailTextLabel.hidden = YES;
}

@end

//
//  LabeledInputTableViewCell.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 28/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LabeledInputTableViewCell : UITableViewCell {
	UITextField *field;
}

@property (nonatomic, retain) UITextField *field;

- (id)initWithReuseIdentifier:(NSString *)identifier;

@end

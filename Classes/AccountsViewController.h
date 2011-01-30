//
//  AccountsViewController.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 28/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountEditorDelegate.h"


@interface AccountsViewController : UITableViewController <AccountEditorDelegate> {
@private
	NSArray* accounts;
}

@end

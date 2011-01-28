/*
 *  AccountViewControllerDelegate.h
 *  VimeoUploader
 *
 *  Created by Tom Adriaenssen on 29/01/11.
 *  Copyright 2011 Adriaenssen BVBA. All rights reserved.
 *
 */

#import "Account.h"

@protocol AccountEditorDelegate 

@required
- (void)accountWasSaved:(Account*)account;

@end

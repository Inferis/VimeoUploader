//
//  AccountViewController.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 28/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@interface AccountViewController : UITableViewController {
@private
	Account* account;
}

- (id)initWithAccount:(Account*)account nibName:(NSString*)nibNameOrNil bundle:(NSBundle*)bundleOrNil;

@property (nonatomic, retain) id delegate;


@end

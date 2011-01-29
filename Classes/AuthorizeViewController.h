//
//  AuthorizeViewController.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 29/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOAuthAPI.h"


@interface AuthorizeViewController : UIViewController <UIWebViewDelegate> {
@private
	MPOAuthAPI* oauth;
	IBOutlet UIWebView *webview;
	NSURL *userAuthURL;
}

@property (nonatomic, readwrite, retain) NSURL *userAuthURL;

@end

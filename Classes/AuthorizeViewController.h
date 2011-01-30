//
//  AuthorizeViewController.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 29/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOAuthAPI.h"
#import "MPOAuthAuthenticationMethodOAuth.h"


@interface AuthorizeViewController : UIViewController <UIWebViewDelegate, MPOAuthAuthenticationMethodOAuthDelegate> {
@private
	MPOAuthAPI* oauth;
	IBOutlet UIWebView *webview;
	NSURL *userAuthURL;
	NSString *oauthVerifier;
}

@property (nonatomic, readwrite, retain) NSURL *userAuthURL;

@end

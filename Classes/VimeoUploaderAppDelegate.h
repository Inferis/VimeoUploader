//
//  VimeoUploaderAppDelegate.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 28/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOAuthAuthenticationMethodOAuth.h"

@interface VimeoUploaderAppDelegate : NSObject <UIApplicationDelegate, MPOAuthAuthenticationMethodOAuthDelegate> {
    UIWindow *window;
	NSString *oauthVerifier;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, readwrite, copy) NSString *oauthVerifier;

@end


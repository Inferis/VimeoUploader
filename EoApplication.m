//
//  EoApplication.m
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 30/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import "EoApplication.h"


@implementation EoApplication

@synthesize currentWebView;

- (BOOL)openURL:(NSURL*)url {
	if (currentWebView != nil) {
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[currentWebView loadRequest:request];
		return YES;
	}
	else {
		return [super openURL:(NSURL *)url];
	}

	
}
	 
@end

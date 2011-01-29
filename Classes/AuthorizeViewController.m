//
//  AuthorizeViewController.m
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 29/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import "AuthorizeViewController.h"
#import "MPOAuthAPI.h"
#import "MPOAuthAuthenticationMethodOAuth.h"
#import "MPURLRequestParameter.h"

#define kConsumerKey @"ee2a775091bad1a55dfff24620353fff"
#define kConsumerSecret @"eb19f48e158271a2"

@interface AuthorizeViewController () 

- (void)handleAuthentication;

@end

@implementation AuthorizeViewController

@synthesize userAuthURL;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestTokenReceived:) name:MPOAuthNotificationRequestTokenReceived object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessTokenReceived:) name:MPOAuthNotificationAccessTokenReceived object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAuthentication) name:UIApplicationDidBecomeActiveNotification object:nil];

	[webview setDelegate:self];
	[webview loadRequest:[NSURLRequest requestWithURL:self.userAuthURL]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self handleAuthentication];
}

- (void)handleAuthentication {
	if (oauth == nil) {
		NSDictionary *credentials = [NSDictionary dictionaryWithObjectsAndKeys: 
									 kConsumerKey, kMPOAuthCredentialConsumerKey, 
									 kConsumerSecret, kMPOAuthCredentialConsumerSecret,
									 nil];
		
		oauth = [[MPOAuthAPI alloc] initWithCredentials:credentials
									  authenticationURL:[NSURL URLWithString:@"http://vimeo.com/oauth"]
											 andBaseURL:[NSURL URLWithString:@"http://vimeo.com/api/rest/v2"]];	
		((MPOAuthAuthenticationMethodOAuth *)oauth.authenticationMethod).delegate = (id <MPOAuthAuthenticationMethodOAuthDelegate>)UIApplication.sharedApplication.delegate;
		[oauth discardCredentials];
	}
	[oauth authenticate];
}

- (void)requestTokenReceived:(NSNotification *)inNotification {
	[self.navigationItem setPrompt:@"Awaiting User Authentication"];
}

- (void)accessTokenReceived:(NSNotification *)inNotification {
	[self.navigationItem setPrompt:@"Access Token Received"];
	
	NSArray* params = [MPURLRequestParameter parametersFromString:@"format=json&method=vimeo.people.getInfo"];
	NSData *downloadedData = [oauth dataForMethod:@"" withParameters:params];
	NSString* result = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
	
	DLog(@"downloadedData of size - %d", [downloadedData length]);
	DLog(@"downloadedData:\n%@", result);
}

#pragma mark -
#pragma mark Stuff

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	// this is a ghetto way to handle this, but it's for when you must use http:// URIs
	// so that this demo will work correctly, this is an example, DONT.BE.GHETTO
	NSURL *authURL = [(id <MPOAuthAuthenticationMethodOAuthDelegate>)[UIApplication sharedApplication].delegate callbackURLForCompletedUserAuthorization];
	if ([request.URL isEqual:authURL]) {
		[[self navigationController] popViewControllerAnimated:YES];
		return NO;
	}
	
	return YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.userAuthURL = nil;

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
}


- (void)dealloc {
    [super dealloc];
}


@end

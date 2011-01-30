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
#import "EoApplication.h"
#import <YAJLIOS/YAJLIOS.h>

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
	((EoApplication*)[UIApplication sharedApplication]).currentWebView = webview;
	[self handleAuthentication];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	((EoApplication*)[UIApplication sharedApplication]).currentWebView = nil;
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
		((MPOAuthAuthenticationMethodOAuth *)oauth.authenticationMethod).delegate = self;
		//((MPOAuthAuthenticationMethodOAuth *)oauth.authenticationMethod).delegate = (id <MPOAuthAuthenticationMethodOAuthDelegate>)UIApplication.sharedApplication.delegate;
		[oauth discardCredentials];
		self.title = @"Authorization";
	}
	[oauth authenticate];
}

- (void)requestTokenReceived:(NSNotification *)inNotification {
	self.title = @"Authorization.";
	DLog(@"Request Token Received");
}

- (void)accessTokenReceived:(NSNotification *)inNotification {
	self.title = @"Authorization..";
	[self.navigationController setNavigationBarHidden:NO animated:YES];

	DLog(@"Access Token Received");
	
	NSArray* params = [MPURLRequestParameter parametersFromString:@"format=json&method=vimeo.people.getInfo"];
	NSData *downloadedData = [oauth dataForMethod:@"" withParameters:params];
	NSString* result = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	NSDictionary *response = [result yajl_JSONWithOptions:YAJLParserOptionsAllowComments error:&error];
	if (error) {
		/* open an alert with an OK button */
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fout" 
														message:error.description
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
	} else {
		DLog(@"response:\n%@", response);
		DLog(@"name = %@", [[response valueForKey:@"person"] valueForKey:@"display_name"]);
		[[self navigationController] popViewControllerAnimated:YES];
	}
}

#pragma mark -
#pragma mark Stuff

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if ([[request.URL host] isEqualToString:@"success"] && [request.URL query].length > 0) {
		NSDictionary *oauthParameters = [MPURLRequestParameter parameterDictionaryFromString:[request.URL query]];
		oauthVerifier = [oauthParameters objectForKey:@"oauth_verifier"];
		[self handleAuthentication];
		return NO;
	}
	
	return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (NSURL *)callbackURLForCompletedUserAuthorization {
	return [NSURL URLWithString:@"x-com-eoapp-oauth://success"];
}

- (BOOL)automaticallyRequestAuthenticationFromURL:(NSURL *)inAuthURL withCallbackURL:(NSURL *)inCallbackURL {
	return YES;
}

- (NSString *)oauthVerifierForCompletedUserAuthorization {
	return oauthVerifier;
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

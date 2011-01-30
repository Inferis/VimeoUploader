//
//  EoApplication.h
//  VimeoUploader
//
//  Created by Tom Adriaenssen on 30/01/11.
//  Copyright 2011 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EoApplication : UIApplication {
	UIWebView *currentWebView;
}

@property (nonatomic, readwrite, retain) UIWebView *currentWebView;


@end

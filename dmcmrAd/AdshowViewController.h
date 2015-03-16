//
//  hanaViewController.h
//  dmcmrAd
//
//  Created by ryu on 2014/06/05.
//  Copyright (c) 2014年 hanahana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hanaAppDelegate.h"

@interface AdshowViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *Debug;
@property (strong, nonatomic) IBOutlet UIWebView *AdshowWebView;
@property (strong, nonatomic) NSTimer *tm;

@property (strong, nonatomic) NSString* lastuuid;

@end

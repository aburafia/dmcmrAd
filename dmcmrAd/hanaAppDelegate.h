//
//  hanaAppDelegate.h
//  dmcmrAd
//
//  Created by ryu on 2014/06/05.
//  Copyright (c) 2014年 hanahana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BleCentral.h"

@interface hanaAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BleCentral* ble;

@end

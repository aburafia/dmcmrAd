//
//  hanaAppDelegate.h
//  dmcmrAd
//
//  Created by ryu on 2014/06/05.
//  Copyright (c) 2014年 hanahana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface hanaAppDelegate : UIResponder <UIApplicationDelegate,
CBCentralManagerDelegate,CBPeripheralDelegate>{
    CBCentralManager *manager;
    CBPeripheral *_peripheral;
}

@property (strong, nonatomic) UIWindow *window;

@end

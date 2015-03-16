//
//  BleCentral.h
//  dmcmrAd
//
//  Created by ryu on 2015/03/14.
//  Copyright (c) 2015年 hanahana. All rights reserved.
//

typedef void (^BlockOnCompletePeripheral)(NSString*);

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BleCentral : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(strong, nonatomic) CBCentralManager *manager;
@property(strong, nonatomic) CBPeripheral *peripheral;
@property(strong, nonatomic) BlockOnCompletePeripheral onCompletePeripheral;

//発見したらコールバックする。
- (BleCentral*)init:(BlockOnCompletePeripheral)complete;

//スキャンする
-(void)activeCentral;

@end

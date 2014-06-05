//
//  hanaAppDelegate.m
//  dmcmrAd
//
//  Created by ryu on 2014/06/05.
//  Copyright (c) 2014年 hanahana. All rights reserved.
//

#import "hanaAppDelegate.h"

#define SERVICE_UUID @"48596A53-8DF0-4BEE-A4DD-8CB2DFBC4D20"
#define CHARACTERISTIC_UUID @"2B6B1035-28B8-4BD4-ACB2-538D350E9DFF"


@implementation hanaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    // Override point for customization after application launch.
    return YES;
}


//CBCentralManagerのステータスが更新されるとコールされる
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"State Updated");
    if(central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"ready");
        
        //BLEを有効にする
        [self activeBLE];
    }
}



-(void)activeBLE{
    CBUUID *serviceUUID = [CBUUID UUIDWithString:SERVICE_UUID];
    [manager scanForPeripheralsWithServices:@[serviceUUID] options:nil];
}



//ペリファレルを発見するとコールされる
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Peripheral discoverd :%@",advertisementData);
    //スキャンを停止し、ペリファレルに接続する
    _peripheral = peripheral;
    [manager stopScan];
    [manager connectPeripheral:peripheral options:nil];
}

//ペリファレルに接続すると、コールされる
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Connected to peripherel");
    //サービスを検索する
    _peripheral.delegate = self;
    [_peripheral discoverServices:@[[CBUUID UUIDWithString:SERVICE_UUID]]];
}

//ペリファレルのサービスを発見するとコールされる
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"Services discovered");
    for (CBService *service in peripheral.services) {
        NSLog(@"Service :%@",service);
        [_peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:CHARACTERISTIC_UUID]]
                                  forService:service];
    }
}

//サービスのキャラクタリスティックを発見するとコールされる
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic:%@",characteristic.UUID);
        [_peripheral readValueForCharacteristic:characteristic];
    }
}

//キャラクタリスティックの値を取得するとコールされる
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSData *data = characteristic.value;
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data = %@",result);
    
    [manager cancelPeripheralConnection:_peripheral];
}


















- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

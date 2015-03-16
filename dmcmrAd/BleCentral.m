//
//  BleCentral.m
//  dmcmrAd
//
//  Created by ryu on 2015/03/14.
//  Copyright (c) 2015年 hanahana. All rights reserved.
//

#import "BleCentral.h"

@implementation BleCentral

- (BleCentral*)init:(BlockOnCompletePeripheral)complete{
    _onCompletePeripheral = complete;
    
    [self startCentral];
    
    return self;
}

- (void)startCentral
{
    //セントルラルを起動し、スキャン開始
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

//CBCentralManagerのステータスが更新されるとコールされる
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"State Updated");
    if(central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"ready");
        
        //BLEを有効にする
        [self activeCentral];
    }
}

//ペリフェラッルのスキャン開始
-(void)activeCentral{
    
    //読み込みがまだおわってない
    if(_manager == NULL || _manager.state != CBCentralManagerStatePoweredOn){
        NSLog(@"activeCentralできません");
        return;
    }
    
    CBUUID *serviceUUID = [CBUUID UUIDWithString:SERVICE_UUID];
    [_manager scanForPeripheralsWithServices:@[serviceUUID] options:nil];
}


//ペリファレルを発見するとコールされる
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Peripheral discoverd :%@",advertisementData);
    //スキャンを停止し、ペリファレルに接続する
    _peripheral = peripheral;
    [_manager stopScan];
    [_manager connectPeripheral:peripheral options:nil];
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
    
    [_manager cancelPeripheralConnection:_peripheral];
    
    //コールバックを実行
    _onCompletePeripheral(result);
    
}



@end

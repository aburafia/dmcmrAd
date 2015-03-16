//
//  hanaAppDelegate.m
//  dmcmrAd
//
//  Created by ryu on 2014/06/05.
//  Copyright (c) 2014年 hanahana. All rights reserved.
//
//
//  このアプリはBLEのセントルラルとして動きます。
//  アドバタイズを行い、一番最初にみつけたレシーバーの情報をもとに、所有者の情報を取得
//  所有者IDを付与してwebviewの表示を行います。
//

#import "hanaAppDelegate.h"



@implementation hanaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    _ble = [[BleCentral alloc] init:^(NSString* uuid){
        [self onComplete:uuid];
    }];
    
    
    // Override point for customization after application launch.
    return YES;
}


-(void)onComplete:(NSString*)uuid{
    
    NSLog(@"読み込みました uuid=%@",uuid);
    
    // 通知先に渡すデータをセット
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                            uuid, @"uuid",
                              nil];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // 通知する
    [nc postNotificationName:@"Connect" object:self userInfo:userInfo];
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

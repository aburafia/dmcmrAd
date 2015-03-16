//
//  hanaViewController.m
//  dmcmrAd
//
//  Created by ryu on 2014/06/05.
//  Copyright (c) 2014年 hanahana. All rights reserved.
//

#import "AdshowViewController.h"

@interface AdshowViewController ()
@end

@implementation AdshowViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // 通知センターに通知要求を登録する
    // この例だと、通知センターに"Connect"という名前の通知がされた時に、
    // hogeメソッドを呼び出すという通知要求の登録を行っている。
    [nc addObserver:self selector:@selector(onConnect:) name:@"Connect" object:nil];
    
    [self resetWebView];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 通知と値を受けるhogeメソッド
-(void)onConnect:(NSNotification*)center{
    // 通知の送信側から送られた値を取得する
    NSString *value = [[center userInfo] objectForKey:@"uuid"];
    NSLog(@"onConnect uuid=%@", value);
    
    if(value == _lastuuid){
        NSLog(@"同一人物");
        return;
    }
    
    _lastuuid = value;

    NSString *urlstr = [NSString stringWithFormat:@"http://%@/request.php?uuid=%@",@"ec2-54-150-206-156.ap-northeast-1.compute.amazonaws.com",value];
    
    NSLog(@"%@",urlstr);
    
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_AdshowWebView loadRequest:req];
 
    _tm = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(reset:) userInfo:nil repeats:NO];
    
}

//だいたい1分で、広告終了。ほーｍページにもどる
-(void)reset:(NSTimer*)timer{
    NSLog(@"1分経ったからリセットね");
    [self resetWebView];
    
    hanaAppDelegate *delegate = (hanaAppDelegate *) [[UIApplication sharedApplication] delegate];

    //再度スキャン開始
    [delegate.ble activeCentral];
}

-(void)resetWebView{
    NSLog(@"tsutaya.tsite.jp表示");
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://tsutaya.tsite.jp/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_AdshowWebView loadRequest:req];
    
}


@end

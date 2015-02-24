//
//  AppDelegate.m
//  eggy
//
//  Created by Freek Sanders on 23-02-15.
//  Copyright (c) 2015 Freek Sanders. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Appirater.h"

@interface AppDelegate ()
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end

@implementation AppDelegate

static NSString * const AppSettingsVersionKey = @"appVersionKey";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // check and save the app version
    self.firstLaunch = NO;
    if(![[NSUserDefaults standardUserDefaults] objectForKey:AppSettingsVersionKey]) {
        self.firstLaunch = YES;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] forKey:AppSettingsVersionKey];
    
    // enable appirater
    [Appirater setAppId:@"727622263"];
    [Appirater setDaysUntilPrompt:0];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setTimeBeforeReminding:4];
    [Appirater appLaunched:YES];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
     NSError *error;
     NSString *path = [[NSBundle mainBundle] pathForResource:@"rooster" ofType:@"mp3"];
     self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
     [self.audioPlayer prepareToPlay];
     [self.audioPlayer play];
}

@end

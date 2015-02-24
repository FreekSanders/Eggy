//
//  TimerViewController.m
//  eggy
//
//  Created by Freek Sanders on 23-02-15.
//  Copyright (c) 2015 Freek Sanders. All rights reserved.
//

#import "TimerViewController.h"
#import "MZTimerLabel.h"
#import "ChameleonFramework/Chameleon.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eggImageView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor flatYellowColor];
    self.eggImageView.image = [UIImage imageNamed:self.imageName];
    [self loadBanner];
    [self scheduleNotification];
    
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:self.timeNeeded];
    timer.timeFormat = @"mm:ss";
    [timer start];
}

- (void)scheduleNotification {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timeNeeded];
    localNotification.alertBody = @"Your eggs are ready!";
    localNotification.soundName = @"rooster.mp3";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)loadBanner {
    self.bannerView.adUnitID = @"ca-app-pub-1290787888052793/5046139069";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"ea1f6598ed1465ca77121c2ac9502a37"];
    [self.bannerView loadRequest:request];
}

@end

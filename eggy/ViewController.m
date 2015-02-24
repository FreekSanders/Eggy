//
//  ViewController.m
//  eggy
//
//  Created by Freek Sanders on 23-02-15.
//  Copyright (c) 2015 Freek Sanders. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"
#import "ChameleonFramework/Chameleon.h"
#import "AppDelegate.h"
#import "UIAlertView+Additions.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *eggSoftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *eggMediumImageView;
@property (weak, nonatomic) IBOutlet UIImageView *eggHardImageView;
@property (weak, nonatomic) NSString *imageNameToSend;
@property (nonatomic) float timeSelected;
@end

@implementation ViewController

static float const EggSoftTime = 3.5 * 60.0;
static float const EggMediumTime = 5.5 * 60.0;
static float const EggHardTime = 8.0 * 60.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor flatYellowColor];
    self.navigationController.navigationBar.barTintColor = [UIColor flatYellowColorDark];
    self.navigationController.navigationBar.tintColor = ContrastColorOf([UIColor flatYellowColorDark], YES);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ContrastColorOf([UIColor flatYellowColorDark], YES)}];
    self.navigationController.navigationBar.translucent = NO;
    
    // add action handlers
    [self.eggSoftImageView setUserInteractionEnabled:YES];
    [self.eggSoftImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eggSoftTapping)]];
    
    [self.eggMediumImageView setUserInteractionEnabled:YES];
    [self.eggMediumImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eggMediumTapping)]];
    
    [self.eggHardImageView setUserInteractionEnabled:YES];
    [self.eggHardImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eggHardTapping)]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] firstLaunch]) {
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).firstLaunch = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Eggy!" message:@"Please choose OK on the next dialog to allow the timer to work in the background\n\nINSTRUCTIONS\n* Boil water\t\n* Add eggs\t\n* Start Eggy\t\n\t* Wait for timer\t\n* Eat eggs!\t" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
            }
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [ChameleonStatusBar statusBarStyleForColor:[UIColor flatYellowColor]];
}

- (void)eggSoftTapping {
    self.timeSelected = EggSoftTime;
    self.imageNameToSend = @"egg_soft";
    [self performSegueWithIdentifier:@"timerSeque" sender:self];
}

- (void)eggMediumTapping {
    self.timeSelected = EggMediumTime;
    self.imageNameToSend = @"egg_medium";
    [self performSegueWithIdentifier:@"timerSeque" sender:self];
}

- (void)eggHardTapping {
    self.timeSelected = EggHardTime;
    self.imageNameToSend = @"egg_hard";
    [self performSegueWithIdentifier:@"timerSeque" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"timerSeque"]) {
        TimerViewController *controller = (TimerViewController *)segue.destinationViewController;
        controller.timeNeeded = self.timeSelected;
        controller.imageName = self.imageNameToSend;
    }
}

@end

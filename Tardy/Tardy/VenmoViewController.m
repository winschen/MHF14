//
//  VenmoViewController.m
//  Tardy
//
//  Created by apple on 9/6/14.
//  Copyright (c) 2014 Apple Test. All rights reserved.
//

#import "VenmoViewController.h"
#import <Venmo-iOS-SDK/Venmo.h>
@interface VenmoViewController ()

@end

@implementation VenmoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![Venmo isVenmoAppInstalled]) {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAPI];
    }
    else {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
    }
    
}

- (IBAction)sendAction:(id)sender {
    [[Venmo sharedInstance] sendPaymentTo:self.toTextField.text
                                   amount:self.amountTextField.text.floatValue*100
                                     note:self.noteTextField.text
                        completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                            if (success) {
                                NSLog(@"Transaction succeeded!");
                            }
                            else {
                                NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                            }
                        }];
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
                                                 VENPermissionAccessProfile]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 NSLog(@"Permission Granted");
                             }
                             else {
                                 NSLog(@"Permission Denied");
                             }
                         }];
}
@end

//
//  VenmoViewController.h
//  Tardy
//
//  Created by apple on 9/7/14.
//  Copyright (c) 2014 Apple Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenmoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *paybutton;

@end

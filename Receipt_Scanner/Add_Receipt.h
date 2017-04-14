//
//  Add_Receipt.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Add_Receipt : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tx_date;
@property (weak, nonatomic) IBOutlet UITextField *tx_company;
@property (weak, nonatomic) IBOutlet UITextField *tx_activity;
@property (weak, nonatomic) IBOutlet UITextField *tx_tax;

@property (weak, nonatomic) IBOutlet UITextField *tx_total;
@property (weak, nonatomic) IBOutlet UITextField *tx_payment;
@property (weak, nonatomic) IBOutlet UITextField *tx_notes;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
- (IBAction)cnfrm:(id)sender;

@end

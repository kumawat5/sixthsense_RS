//
//  AddActivity.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddActivity : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tx_activityname;
@property (weak, nonatomic) IBOutlet UITextField *gl_account;
- (IBAction)add:(id)sender;

@end

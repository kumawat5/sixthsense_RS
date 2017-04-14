//
//  Setting.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Loginuser;
@interface Setting : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property (weak, nonatomic) IBOutlet UITableView *tableview_activity;
- (IBAction)save_setting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tx_username;
@property (weak, nonatomic) IBOutlet UITextField *tx_password;
@property (strong, nonatomic) Loginuser *userInfoFromProfile;
@property (weak, nonatomic) IBOutlet UITextField *confirm_password;
@property (weak, nonatomic) IBOutlet UILabel *activity_activity;
@property (weak, nonatomic) IBOutlet UILabel *activity_glaccount;
@property (weak, nonatomic) IBOutlet UILabel *payment_des;
@property (weak, nonatomic) IBOutlet UILabel *payment_detail;

@end

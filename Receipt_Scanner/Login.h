//
//  Login.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 20/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *login;
- (IBAction)login_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tx_userid;
@property (weak, nonatomic) IBOutlet UITextField *tx_password;
@property (weak, nonatomic) IBOutlet UIButton *btn_outlet;

@end

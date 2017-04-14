//
//  ConfirmActivity.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ConfirmActivity : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tx_activityname;
@property (weak, nonatomic) IBOutlet UITextField *gl_account;
- (IBAction)confirm:(id)sender;
@property(nonatomic,retain) NSString * des;
@property(nonatomic,retain) NSString * detail;
@property (strong) NSManagedObject *device;
@end

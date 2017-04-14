//
//  ConfirmPayment.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ConfirmPayment : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tx_des;
@property (weak, nonatomic) IBOutlet UITextField *tx_detail;
- (IBAction)cancel:(id)sender;

- (IBAction)confirm:(id)sender;
@property (strong) NSManagedObject *device;
@property(nonatomic,retain) NSString * des;
@property(nonatomic,retain) NSString * detail;
@end

//
//  AddPaymentType.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 19/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddPaymentType : UIViewController
@property (strong) NSManagedObject *device;

@property (weak, nonatomic) IBOutlet UITextField *tx_description;
@property (weak, nonatomic) IBOutlet UITextField *tx_details;
- (IBAction)submit:(id)sender;

@end

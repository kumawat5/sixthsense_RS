//
//  Receipt_Detail.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipt_Details.h"

@interface Receipt_Detail : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong) NSManagedObject *device;
@property (weak, nonatomic) IBOutlet UITextField *tx_date;
@property (weak, nonatomic) IBOutlet UITextField *tx_company;
@property (weak, nonatomic) IBOutlet UITextField *tx_activity;
@property (weak, nonatomic) IBOutlet UITextField *tx_tax;
@property (weak, nonatomic) IBOutlet UITextField *tx_total;
@property (weak, nonatomic) IBOutlet UITextField *tx_payment;
@property (weak, nonatomic) IBOutlet UITextField *tx_notes;
- (IBAction)confirm:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *activity_table;
@property (weak, nonatomic) IBOutlet UITableView *payment_table;
- (IBAction)activity_action:(id)sender;
- (IBAction)payment_action:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *camera_img;

- (IBAction)take_recept:(id)sender;

- (IBAction)tapAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *activity_outlet;

@property (weak, nonatomic) IBOutlet UIImageView *sync_img;

@property (weak, nonatomic) IBOutlet UILabel *sync_lbl;

@end

//
//  All_Receipt.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Loginuser;
@class Receipt_Details;

@interface All_Receipt : UIViewController
@property (strong, nonatomic) Receipt_Details *userInfoFromProfile;



@property (weak, nonatomic) IBOutlet UITableView *table_view;
- (IBAction)add:(id)sender;
- (IBAction)logout:(id)sender;
@property BOOL fromSplash;
@property (strong, nonatomic)Loginuser* userInfoFromSignUp;
@property (weak, nonatomic) IBOutlet UIView *view_tag;
@property (weak, nonatomic) IBOutlet UILabel *date_lbl;
@property (weak, nonatomic) IBOutlet UILabel *company_lbl;
@property (weak, nonatomic) IBOutlet UILabel *currency_lbl;
@property (weak, nonatomic) IBOutlet UILabel *total_lbl;
@property (weak, nonatomic) IBOutlet UILabel *sync_lbl;

@property (strong) NSManagedObject *device;


@end

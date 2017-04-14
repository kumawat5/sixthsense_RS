//
//  All_Receipt_Cell.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 17/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface All_Receipt_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date_lbl;
@property (weak, nonatomic) IBOutlet UILabel *company_lbl;
@property (weak, nonatomic) IBOutlet UILabel *currency_lbl;
@property (weak, nonatomic) IBOutlet UILabel *total_lbl;
@property (weak, nonatomic) IBOutlet UILabel *box;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
@property (weak, nonatomic) IBOutlet UILabel *boxes;

@end

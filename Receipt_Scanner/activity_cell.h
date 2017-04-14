//
//  activity_cell.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 21/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface activity_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gl_account_lbl;

@property (weak, nonatomic) IBOutlet UILabel *activity_lbl;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (weak, nonatomic) IBOutlet UILabel *glaccount;
@end

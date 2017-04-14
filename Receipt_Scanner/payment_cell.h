//
//  payment_cell.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 22/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payment_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detail_lbl;

@property (weak, nonatomic) IBOutlet UILabel *des_lbl;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@end

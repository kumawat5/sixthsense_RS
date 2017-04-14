//
//  Loginuser.h
//  Receipt_Scanner
//
//  Created by ankur kumawat on 20/09/16.
//  Copyright © 2016 sixthsense. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
@interface Loginuser : NSManagedObject
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * password;
@end

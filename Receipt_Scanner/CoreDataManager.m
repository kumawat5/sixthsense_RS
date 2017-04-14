//
//  CoreDataManager.m
//  CoreDataMinProject
//
//  Created by InfoEnumY04 on 23/07/15.
//  Copyright (c) 2015 InfoEnumY04. All rights reserved.
//

#import "CoreDataManager.h"

#import "Receipt_Details.h"

@implementation CoreDataManager

+ (instancetype)sharedManager
{
    static CoreDataManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CoreDataManager new];
    });
    return sharedInstance;
}

#pragma mark - Helper

- (Receipt_Details*)newUserInfo
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Loginuser" inManagedObjectContext:self.managedObjectContext];
    return (Receipt_Details*)[[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
}

-(NSArray*)fetchUserInfo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Loginuser" inManagedObjectContext:self.managedObjectContext]];
    NSError *error;
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

-(Receipt_Details*)fetchUserInfoWithEmail:(NSString*)email
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Loginuser" inManagedObjectContext:[CoreDataManager sharedManager].managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userid == %@", email];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
    return [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] firstObject];

}

-(NSArray*)fetchUserInfoWithEmail:(NSString*)email andPassword:(NSString*)password
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Loginuser" inManagedObjectContext:[CoreDataManager sharedManager].managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.userid == %@ AND self.password ==%@", email, password];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.infoenum.CoreDataMinProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Receipt_Scanner" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Receipt_Scanner.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end

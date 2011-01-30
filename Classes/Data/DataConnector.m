//
//  DataConnector.m
//  WinFakt
//
//  Created by Tom Adriaenssen on 17/01/11.
//  Copyright 2011 10to1. Some Rights Reserved.
//

#import "DataConnector.h"

static DataConnector *singletonDataConnector = nil;

@implementation DataConnector

#pragma mark -
#pragma mark Initialization

+ (DataConnector *)sharedInstance {
	@synchronized(self) {
		if (!singletonDataConnector) {
			singletonDataConnector = [[DataConnector alloc] init];
		}
	}
	return singletonDataConnector;
}

#pragma mark -
#pragma mark Core Data configuration

- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
		
		//Undo Support
        NSUndoManager *localUndoManager = [[NSUndoManager  alloc] init];
        [managedObjectContext_ setUndoManager:localUndoManager];
        [localUndoManager release];
		
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
	NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"Storage" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}

#pragma mark -
#pragma mark Undo manager

- (NSUndoManager *)undoManager {
	return [self.managedObjectContext undoManager];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Storage.sqlite"];
    NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
    NSError *error = nil;
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
	[super dealloc];
}

@end


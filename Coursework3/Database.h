//
//  Database.h
//  CW3
//  Created by jordan on 18/10/2014.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject{
    NSMutableArray  *itemid;
    NSMutableArray  *module;
    NSMutableArray  *coursework;
    NSMutableArray  *duedate ;
    NSMutableArray  *description;
}

- (void) readDataFromDatabase;
- (void) QueryDatabase: (NSString*) query;
- (void) copyDatabaseIntoDocumentsDirectory;
- (instancetype) initWithDatabaseFilename:(NSString *)dbFilename;

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic, retain) NSMutableArray *itemid;
@property (nonatomic, retain) NSMutableArray *module;
@property (nonatomic, retain) NSMutableArray *coursework;
@property (nonatomic, retain) NSMutableArray *duedate;
@property (nonatomic, retain) NSMutableArray *description;

@end

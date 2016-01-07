//
//  Database.m
//  CW3
//  Created by jordan on 26/10/2014.
//

#import "Database.h"
#import <sqlite3.h>

@implementation Database
@synthesize itemid, description, coursework, module, duedate;
- (void) readDataFromDatabase{

    // Setup the database object
    itemid = [[NSMutableArray alloc]init];
    module= [[NSMutableArray alloc]init];
    coursework= [[NSMutableArray alloc]init];
    duedate = [[NSMutableArray alloc]init];
    description= [[NSMutableArray alloc]init];
    
    // Set the database file path.
	NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    sqlite3 *database;
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select id, coursework, module, duedate, description from schedule order by duedate";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                // Read data and add each column to an array
                [itemid addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)]];
                [coursework addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)]];
                [module addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)]];
                [duedate addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)]];
                [description addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)]];
            }
        }

        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        // Close the database.
        sqlite3_close(database);
    }
}

//initiate database based on a given filename
-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if (self) {
        // Set the documents directory path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        
        // Keep the database filename.
        self.databaseFilename = dbFilename;
        
        // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

//copy database to document directory so it can be edited
-(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

//function takes query and runs on database
- (void) QueryDatabase: (NSString*) query{
	// Create a sqlite object.
	sqlite3 *sqlite3Database;
	
    // Set the database file path.
	NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];

	// Open the database.
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);

    
	if(openDatabaseResult == SQLITE_OK) {
		sqlite3_stmt *compiledStatement;
		
        // Load all data from database to memory.
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, [query UTF8String], -1, &compiledStatement, NULL);
		if(prepareStatementResult == SQLITE_OK) {
			// Check if the query is non-executable.
                sqlite3_step(compiledStatement);

        }else {
            // In the database cannot be opened then show the error message on the debugger.
			NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
		}
		
		// Release the compiled statement from memory.
		sqlite3_finalize(compiledStatement);
	}
    
    // Close the database.
	sqlite3_close(sqlite3Database);
}

@end

//
//  MasterViewController.h
//  Server Status
//
//  Created by Deokgon Kim on 05/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Server_Status+CoreDataModel.h"
#import "ServerChecker.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    UIRefreshControl *refreshControl;
    
    NSMutableData *_responseData;
}



@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Server *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end


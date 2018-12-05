//
//  DetailViewController.h
//  Server Status
//
//  Created by Deokgon Kim on 05/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server_Status+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end


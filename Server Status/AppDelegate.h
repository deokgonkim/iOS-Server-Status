//
//  AppDelegate.h
//  Server Status
//
//  Created by Deokgon Kim on 05/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


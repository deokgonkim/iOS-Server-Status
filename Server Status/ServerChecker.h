//
//  ServerChecker.h
//  Server Status
//
//  Created by Deokgon Kim on 09/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "Server_Status+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ResponseBlock)(NSUInteger index, NSString *status);

@interface ServerChecker : NSObject <UNUserNotificationCenterDelegate> {
    NSUInteger index;
    NSString *statusUrl;
    NSString *status;
    
    NSMutableData *responseData;
    NSString *serverDateTime;
    
    ResponseBlock responseBlock;
}

//@property (nonatomic, strong) Server *server;

- (id)initWithIndex:(NSUInteger)paramIdx
             andUrl:(NSString *)checkUrl;

- (void)statusCheck:(ResponseBlock)handler;

@end

NS_ASSUME_NONNULL_END

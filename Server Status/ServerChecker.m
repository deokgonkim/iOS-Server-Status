//
//  ServerChecker.m
//  Server Status
//
//  Created by Deokgon Kim on 09/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import "ServerChecker.h"

@implementation ServerChecker

/*
- (id)initWithServer: (Server *)server {
    self = [super init];
    if (self != nil) {
        _server = server;
    }
    
    return self;
}
 */

- (id)initWithIndex:(NSUInteger)paramIdx andUrl:(NSString *)checkUrl {
    self = [super init];
    if (self != nil) {
        index = paramIdx;
        statusUrl = checkUrl;
    }
    
    return self;
}

- (void)statusCheck:(ResponseBlock)handler{
    
    responseBlock = handler;
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:statusUrl]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      //NSLog(@"data - %@ - %@", data, response);
                                      
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                      
                                      NSInteger statusCode = [httpResponse statusCode];
                                      
                                      NSDictionary *headers = [httpResponse allHeaderFields];
                                      
                                      if (statusCode != 200) {
                                          status = [NSString stringWithFormat:@"Error %ld", statusCode];
                                      } else {
                                          status = [NSString stringWithFormat:@"Ok - %@", [headers objectForKey:@"Date"]];
                                      }
                                      
                                      
                                      if (responseBlock) {
                                          responseBlock(index, status);
                                          [self registerLocalNotification];
                                          responseBlock = nil;
                                      }
                                  }];
    
    [task resume];
}

- (void)registerLocalNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Server Status";
    content.body = [NSString stringWithFormat:@"%ul - %@", index, status];
    content.sound = [UNNotificationSound defaultSound];
    
    // 4. update application icon badge number
    //content.badge = [NSNumber numberWithInteger:([UIApplication sharedApplication].applicationIconBadgeNumber + 1)];
    
    // Deliver the notification in five seconds.
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:1.f
                                                  repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"Server%ul", index]
                                                                          content:content
                                                                          trigger:trigger];
    
    /// 3. schedule localNotification
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSLog([NSString stringWithFormat:@"Current delegate : %@", center.delegate]);
    [center setDelegate:self];
    NSLog([NSString stringWithFormat:@"New delegate : %@", center.delegate]);
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"add NotificationRequest succeeded!");
        }
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    // Update the app interface directly.
    NSLog(@"Entered willPresentNotification");
    // Play a sound.
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

@end

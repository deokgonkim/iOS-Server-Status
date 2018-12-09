//
//  ServerChecker.h
//  Server Status
//
//  Created by Deokgon Kim on 09/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server_Status+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ResponseBlock)(Server *server);

@interface ServerChecker : NSObject {
    Server *_server;
    
    NSMutableData *_responseData;
}

@property (nonatomic, strong)ResponseBlock responseBlock;

- (id)initWithServer:(Server *)server;

- (void)statusCheck:(ResponseBlock)handler;

@end

NS_ASSUME_NONNULL_END

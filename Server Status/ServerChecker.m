//
//  ServerChecker.m
//  Server Status
//
//  Created by Deokgon Kim on 09/12/2018.
//  Copyright © 2018 Deokgon Kim. All rights reserved.
//

#import "ServerChecker.h"

@implementation ServerChecker

- (id)initWithServer: (Server *)server {
    self = [super init];
    if (self != nil) {
        _server = server;
    }
    
    return self;
}

- (void)statusCheck:(ResponseBlock)handler{
    
    responseBlock = handler;
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_server.statusUrl]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark -
#pragma mark NSURLConnectionDelegate Methods
//------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSInteger statusCode = [httpResponse statusCode];
    
    NSDictionary *headers = [httpResponse allHeaderFields];
    
    if (statusCode != 200) {
        _server.status = [NSString stringWithFormat:@"Error %ld", statusCode];
    } else {
        _server.status = [NSString stringWithFormat:@"Ok - %@", [headers objectForKey:@"Date"]];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    
    NSLog(@"Response received for URL : %@", [[connection currentRequest] URL]);
    
    NSString* requestedUrl = [[connection currentRequest] URL].absoluteString;
    
    /*
    if (![_server.status containsString:@"Error"]) {
        _server.status = @"Ok";
    }
     */
    
    if (responseBlock) {
        responseBlock(_server);
        responseBlock = nil;
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end

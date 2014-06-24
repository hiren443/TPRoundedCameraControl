//
//  APIConsumer.m
//  WebserviceCall
//
//  Created by TechnoPote.com on 30/04/12
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APIConsumer.h"
#import "JSONKit.h"

@interface APIConsumer ()

@end

@implementation APIConsumer
@synthesize delegate;

-(void)doRequestGet:(NSString*)url{

    NSURL *strurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *theReq=[NSMutableURLRequest requestWithURL:strurl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [theReq setHTTPMethod:@"GET"];

    connection=[NSURLConnection connectionWithRequest:theReq delegate:self];
    
    if(connection){
        responseData = [NSMutableData data];
    }     
}

-(void)doRequestPost:(NSString*)url andData:(NSDictionary*)data{

    NSMutableDictionary *nameElements = [NSMutableDictionary dictionaryWithDictionary:data];     
    NSString *jsonString = [nameElements JSONString];  
    
    if (DEBUG_MODE) {
            NSLog(@"Request  %@",jsonString);
    }
        
    NSMutableURLRequest *theReq=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    [theReq addValue: @"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//     [theReq addValue: @"text/plain" forHTTPHeaderField:@"Accept"];
    [theReq setHTTPMethod:@"POST"];
    [theReq addValue:[NSString stringWithFormat:@"%i",[jsonString length]] forHTTPHeaderField:@"Content-Length"];
    [theReq setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    if(DEBUG_MODE) NSLog(@"the Req %@", theReq);
    connection = [NSURLConnection connectionWithRequest:theReq delegate:self];
    if(connection){
        responseData = [[NSMutableData alloc] init];
    } 
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:HTTP_USERNAME
                                                             password:HTTP_PASSWORD
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

#pragma NSUrlConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [delegate APIResponseArrived:nil];

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *responseString =[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if (DEBUG_MODE) {
       // NSLog(@"%@",responseString);
    }
    [delegate APIResponseArrived:[responseString objectFromJSONString]];
}


@end

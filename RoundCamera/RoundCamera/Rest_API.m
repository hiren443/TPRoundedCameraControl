//
//  Rest_API.m
//  WebserviceCall
//
//  Created by TechnoPote.com on 30/04/12
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Rest_API.h"

@interface Rest_API ()

@end

//#define APP_API_URL @"http://imusti.com/books"
#define APP_API_URL @"http://imusti.com/booksv1_5"
//#define APP_API_URL @"http://design13.imusti.com/booksv1_5"
@implementation Rest_API
@synthesize delegate;
@synthesize _ref_data = __ref_data;
@synthesize token = _token;
@synthesize objAPIConsumer = _objAPIConsumer;

- (id)initWithToken:(NSString*)userToken
{
    self = [super init];
    if(self) {
        self.token = userToken;
        self.objAPIConsumer = [[APIConsumer alloc] init];
        self.objAPIConsumer.delegate = self;
        delegate_on = DELEGATE_WITH_TOKEN;
    }
    return(self);
}

- (id)initWithToken:(NSString*)userToken andData:(NSDictionary*)data{
    self = [super init];
    if(self) {
        self.token = userToken;
        self._ref_data = [NSDictionary dictionaryWithDictionary:data];
        self.objAPIConsumer = [[APIConsumer alloc] init];
        self.objAPIConsumer.delegate = self;
        delegate_on = DELEGATE_WITH_TOKEN_AND_DATA;
    }
    return(self);
}

-(void)APIResponseArrived:(id)Response{
    if (delegate_on == DELEGATE_WITH_TOKEN) {
            [delegate Rest_APIResponseArrived:Response andToken:self.token];
    }else if(delegate_on == DELEGATE_WITH_TOKEN_AND_DATA){
        [delegate Rest_APIResponseArrived:Response andToken:self.token andData:self._ref_data];
    }
}

#pragma mark all public api methods place below this paragma mark

#pragma mark user registration
/*
-(void)user_login{
    NSDictionary *req = [NSDictionary dictionaryWithObjectsAndKeys:@"booksv1_5/login",@"request",
						 [NSDictionary dictionaryWithObjectsAndKeys:apitoken,@"apitoken",
                          userid,@"userid",
                          email,@"email",
                          pwd,@"password",
                          deviceid,@"deviceid"
                          ,nil],@"para",nil];	
    
    [self.objAPIConsumer doRequestPost:[NSString stringWithFormat:@"%@/login", APP_API_URL] andData:req];

}*/
@end

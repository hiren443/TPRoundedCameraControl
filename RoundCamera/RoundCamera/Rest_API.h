//
//  Rest_API.h
//  WebserviceCall
//
//  Created by TechnoPote.com on 30/04/12
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConsumer.h"

typedef enum{
    DELEGATE_WITH_TOKEN,
    DELEGATE_WITH_TOKEN_AND_DATA
} REST_DELEGATE_ON;

@class Rest_API;

@protocol Rest_APIDelegate <NSObject>
-(void)Rest_APIResponseArrived:(id)Response andToken:(NSString*)Token;
-(void)Rest_APIResponseArrived:(id)Response andToken:(NSString*)Token andData:(NSDictionary*)data;
@end

@interface Rest_API : NSObject<APIConsumerDelegate>{
    id<Rest_APIDelegate> delegate;
     NSString *token;
     NSDictionary *_ref_data;
     REST_DELEGATE_ON delegate_on;
}
@property(nonatomic,retain)APIConsumer *objAPIConsumer;
@property(nonatomic,retain)id<Rest_APIDelegate> delegate;
@property(nonatomic,retain)NSString *token;
@property(nonatomic,retain)NSDictionary *_ref_data;

- (id)initWithToken:(NSString*)userToken;
- (id)initWithToken:(NSString*)userToken andData:(NSDictionary*)data;

// all application api methends declare below this comment

/// 
-(void)user_login;

@end

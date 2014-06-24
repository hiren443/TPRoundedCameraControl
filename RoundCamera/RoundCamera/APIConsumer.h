//
//  APIConsumer.h
//  WebserviceCall
//
//  Created by TechnoPote.com on 30/04/12
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol APIConsumerDelegate <NSObject>
-(void)APIResponseArrived:(id)Response;
@end


@interface APIConsumer : NSObject{
    	NSURLConnection *connection;
      	NSMutableData *responseData;
        id <APIConsumerDelegate> delegate;

}
@property(nonatomic,retain)id delegate;
-(void)doRequestGet:(NSString*)url;
-(void)doRequestPost:(NSString*)url andData:(NSDictionary*)data;
@end

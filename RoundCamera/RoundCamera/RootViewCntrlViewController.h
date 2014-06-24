//
//  RootViewCntrlViewController.h
//  RoundCamera
//
//  Created by Hiren J. Bhadreshwara on 04/04/14.
//  Copyright (c) 2014 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface RootViewCntrlViewController : UIViewController<ASIHTTPRequestDelegate>
{
    IBOutlet UIImageView *profImg;
    
}
@property (nonatomic, retain) ASIHTTPRequest *rqstForAudio;

@end

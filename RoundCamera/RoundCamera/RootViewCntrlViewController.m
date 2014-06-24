//
//  RootViewCntrlViewController.m
//  RoundCamera
//
//  Created by Hiren J. Bhadreshwara on 04/04/14.
//  Copyright (c) 2014 digicorp. All rights reserved.
//

#import "RootViewCntrlViewController.h"
#import "NewViewController.h"
#define AudioFolder		@"AudioFolder.plist"
@interface RootViewCntrlViewController ()

@end

@implementation RootViewCntrlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NewViewController *new = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
//    [self.navigationController pushViewController:new animated:YES];

    // Print out the path to verify we are in the right place
/*    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *_strFileName = @"dxflightdata";
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_strFileName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exists = [fileManager fileExistsAtPath:myPathDocs];*/

//    NSString *stringURL = @"http://www.http://vekinis.com/dxfreeurl";
//    NSURL  *url = [NSURL URLWithString:stringURL];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    if (urlData)
//    {
//        NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [path objectAtIndex:0];
//        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"dxflightdata"];
//        [urlData writeToFile:filePath atomically:YES];
//    }

}
- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(void)downloadBook{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"dxflightdata"]];
  //Delete all the previous files
    NSFileManager *filemanager=[[NSFileManager alloc] init];
    if ([filemanager fileExistsAtPath:myPathDocs]) {
        
        NSError *error;
        [filemanager removeItemAtPath:myPathDocs error:&error];
    }
    
    NSString *strAudioURL=@"http://www.http://vekinis.com/dxfreeurl";
    NSString *strPathToAudioCache=[NSString stringWithFormat:@"%@/%@",
                                   [(NSArray*)NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],
                                   AudioFolder];
    
    NSDictionary *dOfAudios=[NSDictionary dictionaryWithContentsOfFile:strPathToAudioCache];
    if([dOfAudios valueForKey:strAudioURL]) {
    } else {
        //        [self.av show];
        NSString *pdf = @"dxflightdata";
        
        NSURL *audioURL = [NSURL URLWithString:strAudioURL];
        NSString *strPathToDownload=[NSString stringWithFormat:@"%@/%@",[(NSArray*)NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],pdf];
      
        if(!self.rqstForAudio || [self.rqstForAudio isFinished]) {
            self.rqstForAudio=[ASIHTTPRequest requestWithURL:audioURL];
            [self.rqstForAudio setDelegate:self];
            [self.rqstForAudio setDownloadProgressDelegate:self];
            [self.rqstForAudio setAllowResumeForFileDownloads:YES];
            [self.rqstForAudio setCachePolicy:ASIUseDefaultCachePolicy];
            [self.rqstForAudio setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [self.rqstForAudio setDidFailSelector:@selector(failedToLoad:)];
            [self.rqstForAudio setDidFinishSelector:@selector(finishedLoading:)];
            [self.rqstForAudio setDownloadDestinationPath:strPathToDownload];
            [self.rqstForAudio startAsynchronous];
        }
    }
}
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes{
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ([[request error] domain] == NetworkRequestErrorDomain && [[request error] code] == ASIAuthenticationErrorType) {
    } else {
    }
}
- (void)failedToLoad:(ASIHTTPRequest*)request {
    self.view.userInteractionEnabled =TRUE;
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Message" message:@"There is a connectivity issue while downloading book. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    av.delegate = self;
    [av show];
}

- (void)finishedLoading:(ASIHTTPRequest*)request {
	NSString *strPathToAudioCache=[NSString stringWithFormat:@"%@",
                                   [(NSArray*)NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    
	NSMutableDictionary *dOfAudios=[NSMutableDictionary dictionaryWithContentsOfFile:strPathToAudioCache];
	
	if([dOfAudios allKeys].count>0) {
		[dOfAudios setValue:[request downloadDestinationPath] forKey:[[request url] description]];
	} else {
		dOfAudios=[NSMutableDictionary dictionary];
		[dOfAudios setValue:[request downloadDestinationPath] forKey:[[request url] description]];
	}
	[dOfAudios writeToFile:strPathToAudioCache atomically:YES];
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"dxflightdata"]];
    NSString *myString = [[NSString alloc] initWithContentsOfFile:myPathDocs encoding:NSUTF8StringEncoding error:NULL];
    
    NSLog(@"MY String %@", myString);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  NewViewController.h
//  RoundCamera
//
//  Created by Hiren J. Bhadreshwara on 04/04/14.
//  Copyright (c) 2014 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate>
{
        IBOutlet UIImageView *profImg;
}
@end

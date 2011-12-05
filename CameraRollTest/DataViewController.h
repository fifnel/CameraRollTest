//
//  DataViewController.h
//  CameraRollTest
//
//  Created by fifnel on 2011/12/05.
//  Copyright (c) 2011年 fifnel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@property (weak, nonatomic) IBOutlet UIButton *NormalCaptureButton;
@property (weak, nonatomic) IBOutlet UIButton *EverythingCaptureButton;

- (IBAction)OnNormalCapture:(id)sender;
- (IBAction)OnEverythingCapture:(id)sender;

@end

CGImageRef UIGetScreenImage(void);
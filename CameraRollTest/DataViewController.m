//
//  DataViewController.m
//  CameraRollTest
//
//  Created by fifnel on 2011/12/05.
//  Copyright (c) 2011年 fifnel. All rights reserved.
//

// 参考:http://kinsentansa.blogspot.com/2010/04/iphone2.html

#import "DataViewController.h"

#import <quartzcore/quartzcore.h>

@implementation DataViewController

@synthesize dataLabel = _dataLabel;
@synthesize EverythingCaptureButton = _OnEverythingCapture;
@synthesize dataObject = _dataObject;
@synthesize NormalCaptureButton = _Output;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNormalCaptureButton:nil];
    [self setEverythingCaptureButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)OnNormalCapture:(id)sender {
    //画面をキャプチャー  
    NSLog(@"画面キャプチャー開始");  
    CGRect rect = [[UIScreen mainScreen] bounds];  
    UIGraphicsBeginImageContext(rect.size); //コンテクスト開始  
    UIApplication *app = [UIApplication sharedApplication];  
    
    //#import <quartzcore/quartzcore.h>をしておかないとrenderInContextで警告が出る  
    [app.keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];  
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext(); //画像を取得してからコンテクスト終了  
    
    //画像を「写真」に保存  
    //JPEGで保存され、クオリーティーはコントロールできないようだ。  
    //ImageMagickのidentifyによるとQuality=93らしい。  
    //UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil); //完了通知が必要ない場合  
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:), nil);    
}  

- (IBAction)OnEverythingCapture:(id)sender {
    //画面キャプチャー開始  
    NSLog(@"画面キャプチャー開始");  
    
    //スクリーンに写っているものすべてを画像化  
    //ドキュメントにはないAPIコール（ひょっとするとREJECTの可能性もあるが、許されているという話も）  
    CGImageRef imgRef = UIGetScreenImage();  
    
    //CGImageRefをUIImageに変換  
    UIImage *img = [UIImage imageWithCGImage:imgRef];  
    
    //キャプチャーしたCGImageRefはUIImageに変換して必要なくなったので解放  
    CGImageRelease(imgRef);  
    
    //画像を「写真」に保存  
    //JPEGで保存され、クオリーティーはコントロールできないようだ。  
    //ImageMagickのidentifyによるとQuality=93らしい。  
    //UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil); //完了通知が必要ない場合  
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:), nil);  
}  

/** 
 * 
 * 画面キャプチャー完了 
 * 
 */  
- (void)onCompleteCapture:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo {  
    NSLog(@"画面キャプチャー完了");  
}  
@end

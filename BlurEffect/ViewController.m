//
//  ViewController.m
//  BlurEffect
//
//  Created by RuanSTao on 15/7/29.
//  Copyright (c) 2015年 JJS-iMac. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>
#import "NetConnectErrorView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view, typically from a nib.
//    UIVisualEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.frame = CGRectMake(100, 100, 200, 200);
//    [self.imgView addSubview:effectView];
//    UIImage *image = [self capture];
//    self.imgView.image = [self applyBlurRadius:10 toImage:image];
    
   }
- (IBAction)button:(id)sender {
//    [NetConnectErrorView showErrorView:ErrorViewType_FullScreen withDurationTime:1];
//        [NetConnectErrorView showErrorView:ErrorViewType_Top withDurationTime:1];
        [NetConnectErrorView showErrorView:ErrorViewType_FullScreen withDurationTime:1 complateBlock:^(ErrorSelectType type) {
            NSLog(@"%d",type);
        }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image
//{
//    UIImage *mask = [UIImage imageNamed:@"mask"];
//    if (radius < 0) radius = 0;
////    CGImageRef ref = CGImageCrea(image.CGImage, CGRectMake(0, 0, 200, 200));
//    
//    CIImage *maskImage = [CIImage imageWithCGImage:mask.CGImage];
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
//    
//    // Setting up gaussian blur
//    CIFilter *filter = [CIFilter filterWithName:@"CIMaskedVariableBlur"];
//    [filter setValue: inputImage forKey: kCIInputImageKey];
//    [filter setValue: maskImage forKey:@"inputMask"];
//    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    
//    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
//    
//    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    UIImage *returnImage = [UIImageEffects imageByApplyingDarkEffectToImage:image];
//    return returnImage;
//}
@end

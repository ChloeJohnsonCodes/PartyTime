//
//  ViewController.m
//  HelloWorld
//
//  Created by Chloe Johnson on 11/23/20.
//

#import "ViewController.h"
#import "AudioPlayer-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

BOOL strobeOn;
BOOL colorOn;
BOOL soundOn;
NSTimer *timer;
NSTimer *timer2;
AVCaptureDevice *device;
BOOL btnToggle;
AudioPlayer *audio;

- (void)viewDidLoad {
    [super viewDidLoad];
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    audio = [AudioPlayer new];
    // Do any additional setup after loading the view.
    btnToggle = NO;
    strobeOn = NO;
    colorOn = NO;
    soundOn = NO;
}

-(IBAction)turnOnTorch {
    [audio createAudioPlayer];
    btnToggle = !btnToggle;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        [device lockForConfiguration:nil];
        if (btnToggle) {
            timer = [NSTimer
                                      scheduledTimerWithTimeInterval:(NSTimeInterval)(0.1)
                                            target:self
                         selector:@selector(strobeLight)
                                             userInfo:nil
                                             repeats:TRUE];
            timer2 = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(0.25) target:self selector:@selector(sound) userInfo:nil repeats:TRUE];
        }
        else {
            if ([device hasFlash] && [device hasTorch]) {
                [device setTorchMode:AVCaptureTorchModeOff];
            }
            [audio stopSound];
            self.view.backgroundColor = [UIColor whiteColor];
            [timer invalidate];
            [timer2 invalidate];
        }
        [device unlockForConfiguration];
    }
}

-(void)strobeLight {
    [device lockForConfiguration:nil];
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    if ([device hasFlash] && [device hasTorch]) {
        if (strobeOn == NO) {
            [device setTorchMode:AVCaptureTorchModeOn];
            strobeOn = YES;
        }
        else {
            [device setTorchMode:AVCaptureTorchModeOff];
            strobeOn = NO;
        }
    }
    if (colorOn == NO) {
        self.view.backgroundColor = color;
        colorOn = YES;
    }
    else {
        self.view.backgroundColor = [UIColor whiteColor];
        colorOn = NO;
    }
}

-(void)sound {
    if (soundOn == NO) {
        [audio playSound];
        soundOn = YES;
    }
    else {
        [audio pauseSound];
        soundOn = NO;
    }
}

@end

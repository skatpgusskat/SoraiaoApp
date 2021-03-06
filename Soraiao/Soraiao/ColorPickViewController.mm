//
//  ColorPickViewController.m
//  Soraiao
//
//  Created by echo on 2014. 10. 16..
//  Copyright (c) 2014년 echo. All rights reserved.
//

#import "ColorPickViewController.h"
struct HsvColor{
    double h;       // angle in degrees
    double s;       // percent
    double v;       // percent
};
#define MIN3(x,y,z) MIN(MIN(x,y),z)
#define MAX3(x,y,z) MAX(MAX(x,y),z)

HsvColor RgbToHsv(Color rgbColor)
{
    typedef struct {
        double r;       // percent
        double g;       // percent
        double b;       // percent
    } rgb;
    rgb in;
    in.r = rgbColor.r / 255.f;
    in.g = rgbColor.g / 255.f;
    in.b = rgbColor.b / 255.f;
    
    HsvColor         out;
    double      min, max, delta;
    
    min = in.r < in.g ? in.r : in.g;
    min = min  < in.b ? min  : in.b;
    
    max = in.r > in.g ? in.r : in.g;
    max = max  > in.b ? max  : in.b;
    
    out.v = max;                                // v
    delta = max - min;
    if( max > 0.0 ) { // NOTE: if Max is == 0, this divide would cause a crash
        out.s = (delta / max);                  // s
    } else {
        // if max is 0, then r = g = b = 0
        // s = 0, v is undefined
        out.s = 0.0;
        out.h = NAN;                            // its now undefined
        return out;
    }
    if( in.r >= max )                           // > is bogus, just keeps compilor happy
        out.h = ( in.g - in.b ) / delta;        // between yellow & magenta
    else
        if( in.g >= max )
            out.h = 2.0 + ( in.b - in.r ) / delta;  // between cyan & yellow
        else
            out.h = 4.0 + ( in.r - in.g ) / delta;  // between magenta & cyan
    
    out.h *= 60.0;                              // degrees
    
    if( out.h < 0.0 )
        out.h += 360.0;
    
    return out;
}
@interface ColorPickViewController ()

@end

@implementation ColorPickViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];

        pickerView = [[ColorPickView alloc]initWithFrame:screenRect parent:self];
        [self.view addSubview:pickerView];
        [self.view sendSubviewToBack:pickerView];
        
        playSongView = [[PlaySongView alloc]initWithFrame:self.view.frame parent:self];
        [self.view addSubview:playSongView];
        [playSongView setHidden:YES];
        [playSongView setUserInteractionEnabled:NO];
        
    }
}

-(void)linkButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.soraiao.net"]];
}
-(void)onColorPicked
{
    struct Color color = pickerView.CenterColor;
    
    HsvColor hsv = RgbToHsv(color);
    NSLog(@"%3f, %3f, %3f",hsv.h, hsv.s, hsv.v);
    if(hsv.h > 165.f && hsv.h <= 185
       && hsv.s >= 0.5f
       && hsv.v >= 0.5f)
    {
        [playSongView loadSong:BREAKER];
        [playSongView setHidden:NO];
        [playSongView setUserInteractionEnabled:YES];
        [pickerView setUserInteractionEnabled:NO];
        [pickerView setHidden:YES];
    }
    else if(hsv.h > 185.f && hsv.h <= 205
            && hsv.s >= 0.5f
            && hsv.v >= 0.5f)
    {
        [playSongView loadSong:HARERUYA];
        [playSongView setHidden:NO];
        [playSongView setUserInteractionEnabled:YES];
        [pickerView setUserInteractionEnabled:NO];
        [pickerView setHidden:YES];
    }
    else if(hsv.h > 205.f && hsv.h <= 225.f
            && hsv.s >= 0.5f
            && hsv.v >= 0.5f)
    {
        [playSongView loadSong:INTHERAIN];
        [playSongView setHidden:NO];
        [playSongView setUserInteractionEnabled:YES];
        [pickerView setUserInteractionEnabled:NO];
        [pickerView setHidden:YES];
    }
    else if(hsv.h > 225.f && hsv.h <= 265
            && hsv.s >= 0.5f
            && hsv.v >= 0.5f)
    {
        [playSongView loadSong:LOOP];
        [playSongView setHidden:NO];
        [playSongView setUserInteractionEnabled:YES];
        [pickerView setUserInteractionEnabled:NO];
        [pickerView setHidden:YES];
    }
    
}


-(void)homeButtonPressed
{
    [playSongView stopSong];
    [self dismissViewControllerAnimated:YES completion:^{
        [playSongView setHidden:YES];
        [playSongView setUserInteractionEnabled:NO];
        [pickerView setUserInteractionEnabled:YES];
        [pickerView setHidden:NO];
    }];
    
}

-(void)pickButtonPressed
{
    [playSongView stopSong];
    [self.view setUserInteractionEnabled:YES];
    [playSongView setHidden:YES];
    [playSongView setUserInteractionEnabled:NO];
    [pickerView setUserInteractionEnabled:YES];
    [pickerView setHidden:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

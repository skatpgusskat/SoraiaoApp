//
//  PlaySongView.m
//  Soraiao
//
//  Created by echo on 2014. 10. 16..
//  Copyright (c) 2014년 echo. All rights reserved.
//

#import "PlaySongView.h"
#import "ColorPickViewController.h"
@implementation PlaySongView
@synthesize player_Breaker;
@synthesize player_Hareruya;
@synthesize player_InTheRain;
@synthesize player_Loop;

- (id)initWithFrame:(CGRect)frame parent:(id)parent
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        player_Breaker = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"breaker" ofType:@"mp3"]] error:nil];
        player_Hareruya = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"hareruya" ofType:@"mp3"]] error:nil];
        player_InTheRain = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"intherain" ofType:@"mp3"]] error:nil];
        player_Loop = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"loop" ofType:@"mp3"]] error:nil];
        
        
        
        backgroundTopImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlaySongViewBackgroundTop"]];
        [self addSubview:backgroundTopImageView];
        
        
        UIImage* home = [UIImage imageNamed:@"home"];
        
        float homeChnagedWidth = home.size.width * 0.75f;
        float homeChnagedHeight = home.size.height * 0.75f;
        
        homeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - homeChnagedWidth - (backgroundTopImageView.frame.size.height - homeChnagedHeight)/2.f,
                                                               (backgroundTopImageView.frame.size.height - (home.size.height * 0.5f))/2.f,
                                                               homeChnagedWidth,
                                                               homeChnagedHeight)];
        [homeButton setImage:home forState:UIControlStateNormal];
        [homeButton addTarget:parent action:@selector(homeButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self addSubview:homeButton];
        
        UIImage* pick = [UIImage imageNamed:@"pick"];
        float pickChnagedWidth = pick.size.width * 0.75f;
        float pickChnagedHeight = pick.size.height * 0.75f;
        pickButton = [[UIButton alloc]initWithFrame:CGRectMake((backgroundTopImageView.frame.size.height - pickChnagedHeight)/2.f,
                                                               (backgroundTopImageView.frame.size.height - pick.size.height * 0.5f)/2.f,
                                                               pickChnagedWidth,
                                                               pickChnagedHeight)];
        [pickButton setImage:pick forState:UIControlStateNormal];
        [pickButton addTarget:parent action:@selector(pickButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self addSubview:pickButton];
        
        
        UIImage* bottomImage = [UIImage imageNamed:@"PlaySongViewBackgroundBottom"];
        backgroundBottomButton = [[UIButton alloc]initWithFrame:CGRectMake(0.f, frame.size.height - bottomImage.size.height, bottomImage.size.width, bottomImage.size.height)];
        [backgroundBottomButton setImage:bottomImage forState:UIControlStateNormal];
        [backgroundBottomButton addTarget:self action:@selector(linkButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backgroundBottomButton];
        
        backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlaySongViewBackground"]];
        [self addSubview:backgroundImageView];
        [self sendSubviewToBack:backgroundImageView];
        
        
        UIImage* playIcon = [UIImage imageNamed:@"PlaySongViewPlayIcon"];
        CGRect newFrame;
        newFrame.origin.x = (frame.size.width - playIcon.size.width) / 2.f;
        newFrame.origin.y = (frame.size.height - playIcon.size.height + backgroundTopImageView.frame.size.height - backgroundBottomButton.frame.size.height) / 2.f;
        newFrame.size = playIcon.size;
        playToggleButton = [[UIButton alloc]initWithFrame:newFrame];
        [playToggleButton setImage:playIcon forState:UIControlStateNormal];
        [self addSubview:playToggleButton];
        [playToggleButton addTarget:self action:@selector(onPlayToggleButtonPressed) forControlEvents:UIControlEventTouchDown];
        
        
        nowPlayer = nil;
        
        isPlaying = false;
    }
    return self;
}
-(void)loadSong:(enum SongType)songType
{
    if(nowPlayer != nil)
    {
        [nowPlayer stop];
        [nowPlayer setCurrentTime:0.f];
        [playToggleButton setImage:[UIImage imageNamed:@"PlaySongViewPlayIcon"] forState:UIControlStateNormal];
        isPlaying = false;
    }
    switch (songType) {
        case BREAKER:
            nowPlayer = player_Breaker;
            break;
        case HARERUYA:
            nowPlayer = player_Hareruya;
            break;
        case INTHERAIN:
            nowPlayer = player_InTheRain;
            break;
        case LOOP:
            nowPlayer = player_Loop;
            break;
            
        default:
            break;
    }
    
    [nowPlayer setCurrentTime:0.f];
    [nowPlayer setNumberOfLoops:-1];
}


-(void)onPlayToggleButtonPressed
{
    if(isPlaying == false){
        isPlaying = true;
        if(nowPlayer != nil)
        {
            [nowPlayer play];
        }
    }
    else {
        isPlaying = false;
        if(nowPlayer != nil)
        {
            [nowPlayer stop];
        }
    }
    [playToggleButton setImage:[UIImage imageNamed:isPlaying ? @"PlaySongViewStopIcon" : @"PlaySongViewPlayIcon"] forState:UIControlStateNormal];
}

-(void)linkButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.soraiao.net"]];
}

-(void)stopSong
{
    if(nowPlayer != nil)
    {
        [nowPlayer stop];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end


//
//  MainWindowController.h
//  WhiteNoise
//
//  Created by Frederik Dietz on 1/8/11.
//  Copyright 2011 XING AG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sound.h"
#import "SoundPlayer.h"

@interface MainWindowController : NSWindowController {
	NSButton *playButton;
	NSSlider *slider;
	NSSegmentedControl *segmentedControl;
	SoundPlayer *soundPlayer;
	
@public
	Sound *selectedSound;
}

- (IBAction)togglePlay:(NSButton *) selectedButton;
- (IBAction)segmentedControlValueChanged:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;

@property (nonatomic, retain) IBOutlet NSButton *playButton;
@property (nonatomic, retain) IBOutlet NSSlider *slider;
@property (nonatomic, retain) SoundPlayer *soundPlayer;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *segmentedControl;

@end

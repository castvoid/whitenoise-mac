#import "MainWindowController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SoundPlayer.h"


@interface MainWindowController ()

- (IBAction)togglePlay:(NSButton *) selectedButton;
- (IBAction)segmentedControlValueChanged:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;

@property (nonatomic, strong) IBOutlet NSButton *playButton;
@property (nonatomic, strong) IBOutlet NSSlider *slider;
@property (nonatomic, strong) SoundPlayer *soundPlayer;
@property (nonatomic, strong) IBOutlet NSSegmentedControl *segmentedControl;

@end



@implementation MainWindowController

- (IBAction)togglePlay:(NSButton *)selectedButton {	
	if (self.soundPlayer.isPlaying) {
		[self.soundPlayer stop];
		[self.playButton setTitle:NSLocalizedString(@"Play", nil)];
	}
	else {
		[self.soundPlayer start];
		[self.playButton setTitle:NSLocalizedString(@"Stop", nil)];
	}
	
}

- (IBAction) sliderValueChanged:(id)sender {
	self.soundPlayer.selectedAmplitude = self.slider.floatValue / 100.0;
}

-(IBAction) segmentedControlValueChanged:(id)sender {
	NSInteger index = [sender selectedSegment];
	Sound *selectedSound = [[self.soundPlayer allSounds] objectAtIndex: index];
	self.soundPlayer.selectedSound = selectedSound;
}

- (void)awakeFromNib {
	self.soundPlayer = [[SoundPlayer alloc] init];
	[self.segmentedControl setSelectedSegment: 0];
}

@end

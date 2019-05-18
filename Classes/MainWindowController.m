#import "MainWindowController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SoundPlayer.h"

@implementation MainWindowController

@synthesize playButton, soundPlayer, slider, segmentedControl;

- (IBAction)togglePlay:(NSButton *)selectedButton {
	NSLog(@"togglePlay");
	
	if (soundPlayer.isPlaying) {
		NSLog(@"stop playing");
		[soundPlayer stop];
//		greenButton = [NSImage imageNamed:@"button_green.png"]; 
//		[playButton setImage:greenButton];
		[playButton setTitle:NSLocalizedString(@"Play", nil)];
	}
	else {
		NSLog(@"start playing");
		[soundPlayer start];
//		redButton = [NSImage imageNamed:@"button_red.png"]; 
//		[playButton setImage:redButton];
		[playButton setTitle:NSLocalizedString(@"Stop", nil)];
	}
	
}

/************************* Slider ********************************/

- (IBAction) sliderValueChanged:(id)sender {
	NSLog(@"slider value changed %f", slider.floatValue);
	soundPlayer.selectedAmplitude = slider.floatValue / 100.0;
} 

/************************* UISegmentedControl *********************/


-(IBAction) segmentedControlValueChanged:(id)sender {
	NSInteger index = [sender selectedSegment];
    NSLog(@"selection index %ld", (long)index);
	selectedSound = [[soundPlayer allSounds] objectAtIndex: index];
	NSLog(@"selectedSound changed %@", selectedSound);
	soundPlayer.selectedSound = selectedSound;
}

- (void)awakeFromNib {
	NSLog(@"awakeFromNib");
	
//	greenButton = [NSImage imageNamed:@"button_green.png"]; 
//	[playButton setImage:greenButton];
	soundPlayer = [[SoundPlayer alloc] init];
	[segmentedControl setSelectedSegment: 0];
}

- (void) dealloc {
	[slider release];
	[playButton release];
	[segmentedControl release];
	[soundPlayer release];
	[selectedSound release];
	[super dealloc];
}	

@end

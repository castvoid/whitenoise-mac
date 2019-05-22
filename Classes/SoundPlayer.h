#import "Sound.h"
#import <AudioUnit/AudioUnit.h>

@interface SoundPlayer : NSObject {
	
@private
	double selectedAmplitude;
	Sound *selectedSound;
	AudioComponentInstance toneUnit;
	Float64 sampleRate;
	NSMutableArray *sounds;
	BOOL playing;
}

- (void)stop;
- (void)start;

@property (nonatomic, assign) double selectedAmplitude;
@property (nonatomic, assign) Sound *selectedSound;
@property (nonatomic, assign, readonly, getter=isPlaying) BOOL playing;

- (NSMutableArray*) allSounds;
- (void) fillBuffer: (Float32*) buffer 
		withFrameNumber: (UInt32) frameNumber;
@end

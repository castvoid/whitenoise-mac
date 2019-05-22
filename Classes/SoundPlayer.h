#import "Sound.h"
#import <AudioUnit/AudioUnit.h>

@interface SoundPlayer : NSObject

- (void)stop;
- (void)start;

@property (nonatomic) double selectedAmplitude;
@property (nonatomic, strong) Sound *selectedSound;
@property (nonatomic, readonly, getter=isPlaying) BOOL playing;

- (NSMutableArray*) allSounds;

@end

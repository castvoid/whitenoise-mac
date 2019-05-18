#import "SoundPlayer.h"
#import "WhiteSound.h"
#import "PinkSound.h"
#import "BrownSound.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SoundPlayer ()
- (void)createToneUnit;
@end

@implementation SoundPlayer

@synthesize selectedAmplitude, selectedSound;
@dynamic playing;

OSStatus RenderTone(void *inRefCon, AudioUnitRenderActionFlags 	*ioActionFlags, const AudioTimeStamp *inTimeStamp, UInt32 inBusNumber, UInt32 inNumberFrames, AudioBufferList *ioData) {
	SoundPlayer *soundPlayer = (SoundPlayer *)inRefCon;
	
  Float32 *buffer = (Float32 *)ioData->mBuffers[0].mData;
	[soundPlayer fillBuffer: buffer withFrameNumber: inNumberFrames];
	return noErr;
}

void ToneInterruptionListener(void *inClientData, UInt32 inInterruptionState) {
	NSLog(@"ToneInterruptionListener");
	SoundPlayer *soundPlayer = (SoundPlayer *)inClientData;
	[soundPlayer stop];
}

- (id) init {
	[super init];
	selectedAmplitude = 0.25;
	selectedSound = [[self allSounds] objectAtIndex: 0];
	sampleRate = 0;
	return self;
}

- (NSMutableArray *) allSounds {
	sounds = [[NSMutableArray alloc] init];
	[sounds addObject:[[WhiteSound alloc] init]];
	[sounds addObject:[[PinkSound alloc] init]];
	[sounds addObject:[[BrownSound alloc] init]];
	return sounds;
}

- (void) fillBuffer:(Float32*) buffer 
		withFrameNumber: (UInt32) frameNumber {	
  UInt32 frame;
	Float32 nextFloat;
  for (frame = 0; frame < frameNumber; ++frame) {
		nextFloat = selectedSound.nextFloat;		
    buffer[frame] = nextFloat * selectedAmplitude;
  }	
}

- (void)stop
{
	NSLog(@"stop");
	
	if (toneUnit) {
		NSLog(@"tone unit stopping");
		AudioOutputUnitStop(toneUnit);
		AudioUnitUninitialize(toneUnit);
		AudioComponentInstanceDispose(toneUnit);
		toneUnit = nil;		
	}
}

- (void)start {
	NSLog(@"start");
	
	[self createToneUnit];
	// Stop changing parameters on the unit
	OSErr err = AudioUnitInitialize(toneUnit);
    NSAssert1(err == noErr, @"Error initializing unit: %hd", err);
	// Start playback
	err = AudioOutputUnitStart(toneUnit);
    NSAssert1(err == noErr, @"Error starting unit: %hd", err);
}

-(BOOL) isPlaying {
	if (toneUnit)
		return YES;
	else
		return NO;
}

- (void)createToneUnit {	
	AudioComponentDescription defaultOutputDescription;
	defaultOutputDescription.componentType = kAudioUnitType_Output;
	defaultOutputDescription.componentSubType = kAudioUnitSubType_DefaultOutput;
	defaultOutputDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
	defaultOutputDescription.componentFlags = 0;
	defaultOutputDescription.componentFlagsMask = 0;
	
	AudioComponent defaultOutput = AudioComponentFindNext(NULL, &defaultOutputDescription);
	NSAssert(defaultOutput, @"Can't find default output");
	
	OSErr err = AudioComponentInstanceNew(defaultOutput, &toneUnit);
    NSAssert1(toneUnit, @"Error creating unit: %hd", err);
	
	AURenderCallbackStruct input;
	input.inputProc = RenderTone;
	input.inputProcRefCon = self;
	err = AudioUnitSetProperty(toneUnit, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Input, 0, &input, sizeof(input));
    NSAssert1(err == noErr, @"Error setting callback: %hd", err);
	
	const int four_bytes_per_float = 4;
	const int eight_bits_per_byte = 8;
	AudioStreamBasicDescription streamFormat;
	streamFormat.mSampleRate = sampleRate;
	streamFormat.mFormatID = kAudioFormatLinearPCM;
	streamFormat.mFormatFlags =
	kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
	streamFormat.mBytesPerPacket = four_bytes_per_float;
	streamFormat.mFramesPerPacket = 1;	
	streamFormat.mBytesPerFrame = four_bytes_per_float;		
	streamFormat.mChannelsPerFrame = 1;	
	streamFormat.mBitsPerChannel = four_bytes_per_float * eight_bits_per_byte;
	err = AudioUnitSetProperty (toneUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &streamFormat, sizeof(AudioStreamBasicDescription));
    NSAssert1(err == noErr, @"Error setting stream format: %hd", err);
}

- (void) dealloc {
	[selectedSound release];
	[sounds release];
	[super dealloc];
}


@end

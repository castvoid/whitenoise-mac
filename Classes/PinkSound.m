#import "PinkSound.h"
#import "WhiteSound.h"

@interface PinkSound (){
    Float32 white, pink, b0, b1, b2, b3, b4, b5, b6;
}

@end

@implementation PinkSound

- (instancetype)init {
	[super init];
	
	b0 = 0;
	b1 = 0;
	b2 = 0;
	b3 = 0;
	b4 = 0;
	b5 = 0;
	b6 = 0;	
	return self;
}

- (NSString*)name {
	return @"Pink";
}

- (Float32)nextFloat {
	white = (Float32) rand()/RAND_MAX - .5f;
	b0 = 0.99886f * b0 + white * 0.0555179f;
	b1 = 0.99332f * b1 + white * 0.0750759f;
	b2 = 0.96900f * b2 + white * 0.1538520f;
	b3 = 0.86650f * b3 + white * 0.3104856f;
	b4 = 0.55000f * b4 + white * 0.5329522f;
	b5 = -0.7616f * b5 - white * 0.0168980f;
	pink = b0 + b1 + b2 + b3 + b4 + b5 + b6 + white * 0.5362f;
	b6 = white * 0.115926f;
	return pink * 0.4;
}

@end

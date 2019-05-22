#import "WhiteSound.h"


@implementation WhiteSound

- (NSString *) name {
		return @"White";
}

- (Float32) nextFloat {
	return (Float32) rand()/RAND_MAX - .5f;
}

@end

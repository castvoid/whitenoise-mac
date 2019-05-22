#import "BrownSound.h"

@interface BrownSound () {
    Float32 _brown;
}

@end


@implementation BrownSound

- (instancetype)init {
	[super init];

	_brown = 0;
	return self;
}

- (NSString *)name {
	return @"Brown";
}

- (Float32)nextFloat {
	while (true) {
		Float32 r = (Float32) rand()/RAND_MAX - .5f;
		_brown += r;
		if (_brown < -8.0f || _brown > 8.0f) {
			_brown -= r;
		} else {
			break;
		}
	}
	return _brown * 0.0625f * 2.2;
}

@end

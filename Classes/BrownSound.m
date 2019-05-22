#import "BrownSound.h"


@implementation BrownSound

- init
{
	[super init];
	
	r = 0;
	m_brown = 0;
	return self;
}

- (NSString *) name {
	return @"Brown";
}

- (Float32) nextFloat {
	while (true) {
		r = (Float32) rand()/RAND_MAX - .5f;
		m_brown += r;
		if (m_brown < -8.0f || m_brown > 8.0f) {
			m_brown -= r;
		} else {
			break;
		}
	}
	return m_brown * 0.0625f * 2.2;
}

@end

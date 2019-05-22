#import <Foundation/Foundation.h>

@class NSString;

@interface Sound : NSObject {
	
}

//- (NSString*) name;
//- (Float32) nextFloat;

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) Float32 nextFloat;

@end

//  FISLocation.m

#import "FISLocation.h"

@implementation FISLocation

- (instancetype)init {
    self = [self initWithName:@""
                     latitude:0.0
                    longitude:0.0];
    return self;
}

- (instancetype)initWithName:(NSString *)name
                    latitude:(CGFloat)latitude
                   longitude:(CGFloat)longitude {
    self = [super init];
    if (self) {
        _name = name;
        _latitude = latitude;
        _longitude = longitude;
        _trivia = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)stringByTruncatingNameToLength:(NSUInteger)length {
    if (length > self.name.length) {
        return self.name;
    }
    
    return [self.name substringToIndex:length];
}

- (BOOL)hasValidData {
    if (self.name.length == 0) {
        return NO;
    }
    if (self.latitude < -90.0 || self.latitude > 90.0) {
        return NO;
    }
    if (self.longitude <= -180.0 || self.longitude > 180.0) {
        return NO;
    }
    return YES;
}

- (FISTrivium *)triviumWithMostLikes {
    if (self.trivia.count == 0) {
        return nil;
    }
    
    NSSortDescriptor *sortByLikesDesc = [NSSortDescriptor sortDescriptorWithKey:@"likes"
     ascending:NO];
     NSArray *triviumByLikes = [self.trivia sortedArrayUsingDescriptors:@[sortByLikesDesc]];
     
     return triviumByLikes[0];
    
    //    FISTrivium *triviumWithMostLikes = self.trivia[0];
    //    for (FISTrivium *currentTrivium in self.trivia) {
    //        if (triviumWithMostLikes.likes < currentTrivium.likes) {
    //            triviumWithMostLikes = currentTrivium;
    //        }
    //    }
    //    return triviumWithMostLikes;
     
}

@end

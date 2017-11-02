#import <Foundation/Foundation.h>

@interface NSArray (JSON)

- (NSString *)JSONRepresentation;

@end

@interface NSDictionary (JSON)

- (NSString *)JSONRepresentation;

@end

@interface NSString (JSON)

- (id)JSONValue;
- (id)JSONMutableValue;

@end
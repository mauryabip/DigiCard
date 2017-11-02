#import "NSObject+JSON.h"

@implementation NSArray (JSON)

- (NSString *)JSONRepresentation
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error!=nil) {
        NSLog(@"Error en NSArray(JSON): %@\ncon NSArray: %@", error.localizedDescription, self.description);
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

@implementation NSDictionary (JSON)

- (NSString *)JSONRepresentation
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error!=nil) {
        NSLog(@"Error en NSDictionary(JSON): %@\ncon NSDictionary: %@", error.localizedDescription, self.description);
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    if ([[string substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"]) {
        string = [string substringWithRange:NSMakeRange(1, string.length - 1)];
    }
    
    NSDictionary *codeDict = [NSDictionary dictionaryWithObjects:@[@[@"RU", @"KZ"], @"MD", @"AM", @"BY", @"UA", @"TJ", @"TM", @"AZ", @"KG", @"UZ"] forKeys:@[@"7", @"373", @"374", @"375", @"380", @"992", @"993", @"994", @"996", @"998"]];
    
    NSString *pattern = @"(^(7|373|374|375|380|992|993|994|996|998){1})";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string
                                                options:0
                                                  range:NSMakeRange(0, string.length)];
    
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    if (matches.count == 0) {
        if (string.length > 12) {
            string = [NSString stringWithString:[string substringWithRange:NSMakeRange(0, 12)]];
        }
        result[KeyPhoneNumber] = [NSString stringWithFormat:@"+%@", string];
        result[KeyCountry] = @"";
        return result;
    }
    
    
    
    [result setObject:codeDict[[string substringWithRange:matches.firstObject.range]] forKey:KeyCountry];
    [result setObject:string forKey:KeyPhoneNumber];
    
    if ([result[KeyCountry] isKindOfClass:NSArray.class] ) {
        if (string.length > 1 && [[string substringWithRange:NSMakeRange(matches.firstObject.range.location + matches.firstObject.range.length, 1)] isEqualToString:@"7"]) {
            [result setObject:result[KeyCountry][1] forKey:KeyCountry];
        } else {
            [result setObject:result[KeyCountry][0] forKey:KeyCountry];
        }
    }
    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    if ([result[KeyCountry] isEqualToString:@"RU"] || [result[KeyCountry] isEqualToString:@"KZ"]) {
        if (mutableString.length > 11) {
            mutableString = [[mutableString substringWithRange:NSMakeRange(0, 11)] mutableCopy];
        }
        if (mutableString.length > 9) {
            [mutableString insertString:@"-" atIndex:9];
        }
        if (mutableString.length > 7) {
            [mutableString insertString:@"-" atIndex:7];
        }
        if (mutableString.length > 4) {
            [mutableString insertString:@") " atIndex:4];
        }
        if (mutableString.length > 1) {
            [mutableString insertString:@" (" atIndex:1];
        }
        [mutableString insertString:@"+" atIndex:0];

        result[KeyPhoneNumber] = mutableString;
    } else if ([result[KeyCountry] isEqualToString:@"MD"] || [result[KeyCountry] isEqualToString:@"AM"] || [result[KeyCountry] isEqualToString:@"TM"]) {
        
        if (mutableString.length > 11) {
            mutableString = [[mutableString substringWithRange:NSMakeRange(0, 11)] mutableCopy];
        }
        if (mutableString.length > 8) {
            [mutableString insertString:@"-" atIndex:8];
        }
        if (mutableString.length > 5) {
            [mutableString insertString:@") " atIndex:5];
        }
        if (mutableString.length > 3) {
            [mutableString insertString:@" (" atIndex:3];
        }
        [mutableString insertString:@"+" atIndex:0];

        result[KeyPhoneNumber] = mutableString;

    } else {
        if (mutableString.length > 12) {
            mutableString = [[mutableString substringWithRange:NSMakeRange(0, 12)] mutableCopy];
        }
        if (mutableString.length > 10) {
            [mutableString insertString:@"-" atIndex:10];
        }
        if (mutableString.length > 8) {
            [mutableString insertString:@"-" atIndex:8];
        }
        if (mutableString.length > 5) {
            [mutableString insertString:@") " atIndex:5];
        }
        if (mutableString.length > 3) {
            [mutableString insertString:@" (" atIndex:3];
        }
        [mutableString insertString:@"+" atIndex:0];

        result[KeyPhoneNumber] = mutableString;
    }
    return result;
}
@end

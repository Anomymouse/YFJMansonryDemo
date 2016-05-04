//
//  WHUCalendarItem.m
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import "WHUCalendarItem.h"

@implementation WHUCalendarItem


//解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        self.dateStr          = [aDecoder decodeObjectForKey:@"dateStr"];
        self.day              = [aDecoder decodeIntForKey:@"day"];
        self.Chinese_calendar = [aDecoder decodeObjectForKey:@"Chinese_calendar"];
        self.holiday          = [aDecoder decodeObjectForKey:@"holiday"];
        self.month            = [aDecoder decodeObjectForKey:@"month"];
        self.year             = [aDecoder decodeObjectForKey:@"year"];
        
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.dateStr forKey:@"dateStr"];
    [aCoder encodeInteger:self.day forKey:@"day"];
    [aCoder encodeObject:self.Chinese_calendar forKey:@"Chinese_calendar"];
    [aCoder encodeObject:self.holiday forKey:@"holiday"];
    [aCoder encodeObject:self.month forKey:@"month"];
    [aCoder encodeObject:self.year forKey:@"year"];
}




@end

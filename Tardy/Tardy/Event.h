//
//  Event.h
//  Tardy
//
//  Created by apple on 9/6/14.
//  Copyright (c) 2014 Apple Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) bool participating;
@property (nonatomic) bool arrived;
@property (nonatomic, strong) NSMutableArray *attendees;

@end

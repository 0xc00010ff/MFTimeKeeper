//
//  MFTimeKeeper.h
//

#import <Foundation/Foundation.h>

@interface MFTimeKeeper : NSObject

/** 
 * Registrant ID allows multiple files to use the same
 * event names without collision. 
 */
- (instancetype)initWithRegistrantID:(NSString*)registrantID;

/** 
 * Checks if an event has occurrence in the specified time frame.
 * Returns NO if the event has never been registered.
 */
- (BOOL)itsBeen:(double)minutes minutesSince:(NSString*)eventName;

/**
 * Returns the number of minutes since the specified event or 0
 */
- (double)minutesSinceEvent:(NSString*)eventName;

/**
 * Returns the last recorded date of the specified event or nil
 */
- (NSDate*)lastDateOfEvent:(NSString*)eventName;

/**
 * Saves the current timestamp and eventname to disk
 */
- (void)recordEvent:(NSString*)eventName;

/**
 * Removes any history of events with the specified name
 */
- (void)forgetEvent:(NSString*)eventName;

@end

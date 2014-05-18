//
//  MFTimeKeeper.h
//

#import <Foundation/Foundation.h>

@interface MFTimeKeeper : NSObject

/**
 * Returns an intialized timekeeper under the default namespace
 */
+ (instancetype)timeKeeper;

/** 
 * Registrant ID allows multiple files to use the same
 * event names without collision. 
 */
- (instancetype)initWithRegistrantID:(NSString*)registrantID;

/**
 * Convenience method to if an event exists at all
 */
- (BOOL)eventExists:(NSString*)eventName;

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

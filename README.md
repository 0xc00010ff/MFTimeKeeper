MFTimeKeeper
============

#####Most common usage:

```objective-c
/* in one of the UIViewController view lifecycle methods: */
if ([self.timeKeeper itsBeen:15 minutesSince:@"Refreshed")
{
    // Actually refresh something, then:
    [self.timeKeeper recordEvent:@"Refreshed"];
}

```

##### Methods
```objective-c
/**
* Optional initializer that adds protection against name collisions 
*/
- (instancetype)initWithRegistrantID:(NSString*)registrantID;
```


```objective-c
/**
* Checks if an event has occurrence in the specified time frame.
* Returns NO if the event has never been registered.
*/
- (BOOL)itsBeen:(double)minutes minutesSince:(NSString*)eventName;
```
```objective-c
/**
* Returns the number of minutes since the specified event or 0
*/
- (double)minutesSinceEvent:(NSString*)eventName;
```
```objective-c
/**
* Returns the last recorded date of the specified event or nil
*/
- (NSDate*)lastDateOfEvent:(NSString*)eventName;
```
```objective-c
/**
* Saves the current timestamp and eventname to disk
*/
- (void)recordEvent:(NSString*)eventName;
```
```objective-c
/**
* Removes any history of events with the specified name
*/
- (void)forgetEvent:(NSString*)eventName;
```

MFTimeKeeper
============
#### An event tracking utility for Cocoa projects that records titled timestamps to disk to allow behavior based on past actions.

##### Common usage patterns:
```objective-c
if ([[MFTimeKeeper timeKeeper] itsBeen:15 minutesSince:@"Refreshed"])
{
    // Actually refresh something, then:
    [timeKeeper recordEvent:@"Refreshed"];
}
```

```objective-c
MFTimeKeeper* timeKeeper = [MFTimeKeeper initWithRegistrantID:NSStringFromClass([self class])];
if (![timeKeeper eventExists:@"InitialLaunch"])
{
    // do something you would only do on the first launch, then:
    [timeKeeper recordEvent:@"InitialLaunch"];
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
* Returns an intialized timekeeper under the default namespace
*/
+ (instancetype)timeKeeper;
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

##### Notes:
Keep in mind that the events will never cross namespaces. Using the `[MFTimeKeeper timeKeeper]` factory method will track events under the default global namespace. You can also make your own global namespace, or choose to namespace events by your class name or any arbitrary name, but make sure that you are consistent and aware of what bucket you are putting your events into. 

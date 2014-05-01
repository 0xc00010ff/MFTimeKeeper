//
//  MFTimeKeeper.m
//

#import "MFTimeKeeper.h"

static NSString* kDefaultFilePath = @"_scheduler.plist";
static NSString* kDefaultRegistrantID = @"_-d-e-f-a-u-l-t-"; // hopefully no one chooses this exact name for their registration

@interface MFTimeKeeper()
@property (nonatomic, strong, readonly) NSString* registrantID;
@property (nonatomic, strong, readonly) NSString* filePath;
@property (nonatomic, strong) NSMutableDictionary* events;
@end

@implementation MFTimeKeeper

#pragma mark - Initializers -

+ (instancetype)timeKeeper
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    return self = [self initWithRegistrantID:kDefaultRegistrantID];
}

- (instancetype)initWithRegistrantID:(NSString*)registrantID
{
    if (self = [super init])
    {
        if (!registrantID) { registrantID = kDefaultRegistrantID; }
        _registrantID = registrantID;
    }
    return self;
}

#pragma mark - Public Methods -

- (BOOL)itsBeen:(double)minutes minutesSince:(NSString *)eventName
{
    BOOL itsBeenLongEnough = NO;
    NSDate* lastEventOccurrence = [self lastDateOfEvent:eventName];
    if (lastEventOccurrence)
    {
        NSTimeInterval minutesSinceEvent = [self minutesSinceEvent:eventName];
        if (minutesSinceEvent > minutes)
        {
            itsBeenLongEnough = YES;
        }
    }
    
    return itsBeenLongEnough;
}

- (double)minutesSinceEvent:(NSString *)eventName
{
    NSTimeInterval minutesSinceEvent;
    
    NSDate* lastEventOccurrence = [self lastDateOfEvent:eventName];
    if (lastEventOccurrence)
    {
        NSTimeInterval secondsSinceEvent = [[NSDate date] timeIntervalSinceDate:lastEventOccurrence];
        minutesSinceEvent = secondsSinceEvent / 60;
    }
    else
    {
        minutesSinceEvent = 0;
    }
    
    return minutesSinceEvent;
}

- (NSDate *)lastDateOfEvent:(NSString *)eventName
{
    return self.events[eventName];
}

- (void)recordEvent:(NSString *)eventName
{
    self.events[eventName] = [NSDate date];
    [self saveEventsInBackground];
}

- (void)forgetEvent:(NSString *)eventName
{
    [self.events removeObjectForKey:eventName];
}

#pragma mark - Utilities -

- (void)saveEventsInBackground
{
    // save the event to disk in the background
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (![self.events writeToFile:self.filePath atomically:YES]) {
            NSLog(@"Error recording event to disk in BMScheduler");
        }
    });
}

#pragma mark - Accessors -

- (NSString*)filePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* eventsPath = [self.registrantID stringByAppendingString:kDefaultFilePath];
    return [documentsDirectory stringByAppendingPathComponent:eventsPath];
}

- (NSMutableDictionary*)events
{
    if (!_events)
    {
        _events = [NSMutableDictionary dictionaryWithContentsOfFile:self.filePath];
        if (!_events) { _events = [NSMutableDictionary dictionary]; }
    }
    return _events;
}

@end
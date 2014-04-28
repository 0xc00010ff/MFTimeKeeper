//
//  ViewController.m
//  Example
//
//  Created by ----- --- on 4/19/14.
//

#import "ViewController.h"
#import "MFTimeKeeper.h"

static NSString* const kEventNameTest = @"test";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventRecordedLabel;
@property (nonatomic, strong) MFTimeKeeper* timeKeeper;
@end

@implementation ViewController

#pragma mark - View Lifecycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.statusLabel.text = @"Record an event to get started";
    self.eventRecordedLabel.text = @"";
}

- (void)dealloc
{
    [self.timeKeeper forgetEvent:kEventNameTest];
}

#pragma mark - Actions -

- (IBAction)testButtonPressed:(UIButton *)sender
{
    double minutes = [self.secondsLabel.text doubleValue] / 60;
    
    if ([self.timeKeeper itsBeen:minutes minutesSince:kEventNameTest])
    {
        [self showPositiveStatus];
    }
    else if ([self.timeKeeper lastDateOfEvent:kEventNameTest])
    {
        double minutes = [self.timeKeeper minutesSinceEvent:kEventNameTest];
        [self showNegativeStatusWithRemainingTime:minutes];
    }
    else
    {
        // do nothing because no event has been recorded yet
    }
}

- (IBAction)recordButtonPressed:(UIButton *)sender
{
    [self.timeKeeper recordEvent:kEventNameTest];
    NSString* dateString = [[self.timeKeeper lastDateOfEvent:kEventNameTest] description];
    self.eventRecordedLabel.text = [NSString stringWithFormat:@"Last recorded event:\n %@", dateString];
}

- (IBAction)plusButtonPressed:(UIButton *)sender
{
    NSInteger newTime = [self.secondsLabel.text integerValue] + 1;
    self.secondsLabel.text = [NSString stringWithFormat:@"%d", newTime];
}
- (IBAction)minusButtonPressed:(UIButton *)sender
{
    NSInteger newTime = [self.secondsLabel.text integerValue] - 1;
    self.secondsLabel.text = [NSString stringWithFormat:@"%d", newTime];
}

#pragma mark - Utilities -

- (void)showPositiveStatus
{
    self.statusLabel.textColor = [UIColor greenColor];
    self.statusLabel.text = @"It's been long enough.";
}

- (void)showNegativeStatusWithRemainingTime:(double)minutes
{
    double seconds = minutes * 60;
    double remainingTime = [self.secondsLabel.text doubleValue] - seconds;
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.text = [NSString stringWithFormat:@"Wait %.02f more seconds", remainingTime];
}

#pragma mark - Accessors -

- (MFTimeKeeper*)timeKeeper
{
    if (!_timeKeeper)
    {
        _timeKeeper = [[MFTimeKeeper alloc] initWithRegistrantID:NSStringFromClass([self class])];
    }
    return _timeKeeper;
}

@end

MFTimeKeeper
============

Most common usage:

```objective-c
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if ([self.timeKeeper itsBeen:15 minutesSince:@"Refreshed")
  {
    [self refreshSomething];
  }
}
```

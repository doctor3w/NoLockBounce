//
//
//    Created by drewsdunne 
//         Feb 22 2014
//
//

@interface UIDevice (de)
- (BOOL)iOSVersionIsAtLeast:(NSString *)vers;
@end

#define IS_IOS_71_OR_LATER() [[UIDevice currentDevice] iOSVersionIsAtLeast: @"7.1"]
#define IS_IOS_70()          ([[UIDevice currentDevice] iOSVersionIsAtLeast: @"7.0"] && !IS_IOS_71_OR_LATER())

@interface SBAlertView : UIView
@end

@interface SBLockScreenView : SBAlertView
- (float)hintDisplacement;
@end

@interface SBLockScreenBounceAnimator
- (void)_handleTapGesture:(id)arg1;
//-(void)addTapExcludedView:(id)arg1;
//-(id)initWithView:(id)arg1;
@end

@implementation UIDevice (OSVersion)
- (BOOL)iOSVersionIsAtLeast:(NSString*)version {
    NSComparisonResult result = [[self systemVersion] compare:version options:NSNumericSearch];
    return (result == NSOrderedDescending || result == NSOrderedSame);
}
@end

%group iOS7
%hook SBLockScreenBounceAnimator
- (void)_handleTapGesture:(id)arg1 {
	//Do not handle tap gesture
	arg1 = NULL;
}
%end
%end

%group iOS71
%hook SBLockScreenView
- (float)hintDisplacement {
	return 0;
}
%end
%hook SBLockScreenBounceAnimator
- (void)_handleTapGesture:(id)arg1 {
	//Do not handle tap gesture
	arg1 = NULL;
}
/*- (id)initWithView:(id)arg1 {
	//Grab the original animator for returning later
	id animator = %orig;

	//Add the view to excluded tap animation view list
	[self addTapExcludedView:arg1];

	//return the animator
	return animator;
}*/
%end
%end

%ctor {
	if (IS_IOS_71_OR_LATER())
	{
		%init(iOS71);
	} else if (IS_IOS_70())
	{
		%init(iOS7);
	} else {

	}
}
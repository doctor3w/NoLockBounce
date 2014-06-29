//
//
//    Created by drewsdunne 
//         Feb 22 2014
//
//

@interface SBAlertView : UIView
@end

@interface SBLockScreenView : SBAlertView
@end

@interface SBLockScreenBounceAnimator
- (void)_handleTapGesture:(id)arg1;
-(void)addTapExcludedView:(id)arg1;
-(id)initWithView:(id)arg1;
@end

%hook SBLockScreenBounceAnimator

- (void)_handleTapGesture:(id)arg1 {
	//Do not handle tap gesture
	arg1 = NULL;
}

- (id)initWithView:(id)arg1 {
	//Grab the original animator for returning later
	id animator = %orig;

	//Add the view to excluded tap animation view list
	[self addTapExcludedView:arg1];

	//return the animator
	return animator;
}

%end
//
//  PopUpView.m
//
//  Created by Tom Parry on 1/04/11.
//  Copyright 2011 b2cloud. All rights reserved.
//

#import "PopUpView.h"

@implementation PopUpView

@synthesize disablesScreen;
@synthesize popsUp;
@synthesize popAmount;
@synthesize popUpSpeed;
@synthesize popDownSpeed;

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if(self)
	{
		disablesScreen = NO;
		popsUp = YES;
		popAmount = 1.0;
		popUpSpeed = 0.3;
		popDownSpeed = 0.2;
		touchBlocker = [[UIView alloc] init];
	}
	
	return self;
}

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if(self)
	{
		disablesScreen = NO;
		popsUp = YES;
		popAmount = 1.0;
		popUpSpeed = 0.3;
		popDownSpeed = 0.2;
		touchBlocker = [[UIView alloc] init];
	}
	
	return self;
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	
	if(self.superview == nil)
		return;
	
	[touchBlocker setFrame:self.superview.bounds];
	[touchBlocker setAlpha:0.0];
	[touchBlocker setBackgroundColor:[UIColor blackColor]];
	[self.superview addSubview:touchBlocker];
	
	[self.superview bringSubviewToFront:self];
}

#pragma mark -

- (void) show
{
	[UIView beginAnimations:@"popUpAnimation" context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:popUpSpeed];
	
	self.transform = CGAffineTransformMakeTranslation(0, (int)(self.frame.size.height * ((popsUp) ? -1 : 1) * popAmount));
	
	[UIView commitAnimations];
	
	if(disablesScreen)
	{
		[touchBlocker setAlpha:POPUPVIEW_BLOCK_ALHPA];
		
		//	Animation for background overlay
		CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		fadeAnimation.duration = popUpSpeed;
		fadeAnimation.repeatCount = 0;
		fadeAnimation.fromValue = @0.0f; 
		fadeAnimation.toValue = [NSNumber numberWithFloat:POPUPVIEW_BLOCK_ALHPA];
		[[touchBlocker layer] addAnimation:fadeAnimation forKey:@"opacity"];
	}
}

- (void) hide
{
	[UIView beginAnimations:@"popUpAnimation" context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:popDownSpeed];
	
	self.transform = CGAffineTransformMakeTranslation(0, 0);
	
	[UIView commitAnimations];
	
	if(disablesScreen)
	{
		[touchBlocker setAlpha:0.0];
		
		//	Animation for background overlay
		CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		fadeAnimation.duration = popDownSpeed;
		fadeAnimation.repeatCount = 0;
		fadeAnimation.fromValue = [NSNumber numberWithFloat:POPUPVIEW_BLOCK_ALHPA]; 
		fadeAnimation.toValue = @0.0f;
		[[touchBlocker layer] addAnimation:fadeAnimation forKey:@"opacity"];
	}
}

@end

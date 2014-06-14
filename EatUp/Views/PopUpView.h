//
//  PopUpView.h
//
//  Created by Tom Parry on 1/04/11.
//  Copyright 2011 b2cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define POPUPVIEW_BLOCK_ALHPA 0.6

@interface PopUpView : UIView
{
	UIView* touchBlocker;
}

@property (nonatomic, assign) BOOL disablesScreen;
@property (nonatomic, assign) BOOL popsUp;
@property (nonatomic, assign) double popAmount;
@property (nonatomic, assign) double popUpSpeed;
@property (nonatomic, assign) double popDownSpeed;

- (void) show;
- (void) hide;

@end

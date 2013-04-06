/* 
 
 CachedAccelerometer.m:
 
 Copyright (C) 2011 Steven Yi
 
 This file is part of Csound for iOS.
 
 The Csound for iOS Library is free software; you can redistribute it
 and/or modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.   
 
 Csound is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with Csound; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 02111-1307 USA
 
 */

#import "CachedAccelerometer.h"

@interface CachedAccelerometer() {
    CMMotionManager* mManager;
}
@end


@implementation CachedAccelerometer

static NSString *CS_ACCEL_X = @"accelerometerX";
static NSString *CS_ACCEL_Y = @"accelerometerY";
static NSString *CS_ACCEL_Z = @"accelerometerZ";

-(id)init:(CMMotionManager*)cmManager {
    if (self = [super init]) {
        mManager = cmManager;
    }
    return self;
}

-(void)setup:(CsoundObj*)csoundObj {
    channelPtrX = [csoundObj getInputChannelPtr:CS_ACCEL_X];
    channelPtrY = [csoundObj getInputChannelPtr:CS_ACCEL_Y];
    channelPtrZ = [csoundObj getInputChannelPtr:CS_ACCEL_Z];    
    
    [self updateValuesToCsound];
    
    self.cacheDirty = YES;
}

-(void)updateValuesToCsound {
    *channelPtrX = mManager.accelerometerData.acceleration.x;
    *channelPtrY = mManager.accelerometerData.acceleration.y;
    *channelPtrZ = mManager.accelerometerData.acceleration.z;   
}

@end

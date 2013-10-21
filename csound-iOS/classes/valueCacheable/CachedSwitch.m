/* 
 
 CachedSwitch.h:
 
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

#import "CachedSwitch.h"

@implementation CachedSwitch

-(void)updateValueCache:(id)sender {
    self.cachedValue = ((UISwitch*)sender).on ? 1 : 0;
    self.cacheDirty = YES;
}

-(CachedSwitch*)init:(UISwitch*)uiSwitch channelName:(NSString*)channelName {
    if (self = [super init]) {
        self.mSwitch = uiSwitch;
        self.channelName = channelName;
    }
    return self;
}

-(void)setup:(CsoundObj*)csoundObj {
    self.cachedValue = self.mSwitch.on ? 1 : 0;
    self.cacheDirty = YES;
    self.channelPtr = [csoundObj getInputChannelPtr:self.channelName
                                        channelType:CSOUND_CONTROL_CHANNEL];
    [self.mSwitch addTarget:self action:@selector(updateValueCache:) forControlEvents:UIControlEventValueChanged];
}


-(void)updateValuesToCsound {
    if (self.cacheDirty) {
        *self.channelPtr = self.cachedValue;
        self.cacheDirty = NO;
    }
}

-(void)cleanup {
    [self.mSwitch removeTarget:self action:@selector(updateValueCache:) forControlEvents:UIControlEventValueChanged];
}

@end

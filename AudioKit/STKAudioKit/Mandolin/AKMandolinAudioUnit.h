// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

#pragma once
#import <AudioKit/AKAudioUnit.h>

@interface AKMandolinAudioUnit : AKAudioUnit
@property (nonatomic) float detune;
@property (nonatomic) float bodySize;

- (void)setFrequency:(float)frequency course:(int)course;
- (void)pluckCourse:(int)course position:(float)position velocity:(int)velocity;
- (void)muteCourse:(int)course;

@end


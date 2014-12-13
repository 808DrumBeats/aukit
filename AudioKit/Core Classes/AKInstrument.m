//
//  AKInstrument.m
//  AudioKit
//
//  Created by Aurelius Prochazka on 4/11/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "AKInstrument.h"
#import "AKManager.h"
#import "AKAssignment.h"
#import "AKStereoAudio.h"

typedef enum {
    kInstrument=1,
    kStartTime=2,
    kDuration=3
} kRequiredPValues;

@implementation AKInstrument
{
    AKOrchestra *orchestra;
    NSMutableString *innerCSDRepresentation;
    int _myID;
}

// -----------------------------------------------------------------------------
#  pragma mark - Initialization
// -----------------------------------------------------------------------------

static int currentID = 1;
+ (void)resetID { currentID = 1; }

- (instancetype)init {
    self = [super init];
    if (self) {
        _myID = currentID++;
        _properties = [[NSMutableArray alloc] init];
        _noteProperties = [[NSMutableArray alloc] init];
        _userDefinedOperations = [[NSMutableSet alloc] init];
        _fTables = [[NSMutableSet alloc] init];
        innerCSDRepresentation = [NSMutableString stringWithString:@""];
    }
    return self;
}

- (int)instrumentNumber {
    return _myID;
}

- (NSString *)uniqueName {
    return [NSString stringWithFormat:@"%@%i", [self class], _myID];
}

// -----------------------------------------------------------------------------
#  pragma mark - Properties
// -----------------------------------------------------------------------------


- (void) addProperty:(AKInstrumentProperty *)newProperty;
{
    [_properties addObject:newProperty];
}

- (void) addProperty:(AKInstrumentProperty *)newProperty
            withName:(NSString *)name;
{
    [_properties addObject:newProperty];
    [newProperty setName:name];
}


- (void)addNoteProperty:(AKNoteProperty *)newNoteProperty;
{
    [_noteProperties addObject:newNoteProperty];
}



// -----------------------------------------------------------------------------
#  pragma mark - F Tables
// -----------------------------------------------------------------------------

- (void)addFTable:(AKFTable *)newFTable {
    [_fTables addObject:newFTable];
}

- (void)addDynamicFTable:(AKFTable *)newFTable {
    [innerCSDRepresentation appendString:[newFTable stringForCSD]];
    [innerCSDRepresentation appendString:@"\n"];
}

// -----------------------------------------------------------------------------
#  pragma mark - Operations
// -----------------------------------------------------------------------------

- (void)connect:(AKParameter *)newOperation {
    [innerCSDRepresentation appendString:[newOperation stringForCSD]];
    [innerCSDRepresentation appendString:@"\n"];
}

- (void)addUDO:(AKParameter *)newUserDefinedOperation {
    [_userDefinedOperations addObject:newUserDefinedOperation];
    [innerCSDRepresentation appendString:[newUserDefinedOperation stringForCSD]];
    [innerCSDRepresentation appendString:@"\n"];
}

- (void)addString:(NSString *)newString {
    [innerCSDRepresentation appendString:newString];
    [innerCSDRepresentation appendString:@"\n"];
}

- (void)assignOutput:(AKParameter *)output to:(AKParameter *)input {
    if ([output class] == [AKStereoAudio class] && [input respondsToSelector:@selector(leftOutput)]) {
        AKStereoAudio *stereoOutput = (AKStereoAudio *)output;
        AKStereoAudio *stereoInput  = (AKStereoAudio *)input;
        
        AKAssignment *auxLeftOutputAssign = [[AKAssignment alloc] initWithOutput:stereoOutput.leftOutput
                                                                           input:stereoInput.leftOutput];
        [self connect:auxLeftOutputAssign];

        AKAssignment *auxRightOutputAssign = [[AKAssignment alloc] initWithOutput:stereoOutput.rightOutput
                                                                           input:stereoInput.rightOutput];
        [self connect:auxRightOutputAssign];

    
    } else {
        AKAssignment *auxOutputAssign = [[AKAssignment alloc] initWithOutput:output
                                                                       input:input];
        [self connect:auxOutputAssign];
    }
}

- (void)resetParameter:(AKParameter *)parameterToReset {
    if ([parameterToReset class] == [AKStereoAudio class]) {
        AKStereoAudio *stereoParameterToReset = (AKStereoAudio *)parameterToReset;
        [innerCSDRepresentation appendString:
         [NSString stringWithFormat:@"%@ = 0\n", stereoParameterToReset.leftOutput]];
        [innerCSDRepresentation appendString:
         [NSString stringWithFormat:@"%@ = 0\n", stereoParameterToReset.rightOutput]];
    } else {
        [innerCSDRepresentation appendString:
         [NSString stringWithFormat:@"%@ = 0\n", parameterToReset]];
    }
}

// -----------------------------------------------------------------------------
#  pragma mark - Csound Implementation
// -----------------------------------------------------------------------------

- (void)joinOrchestra:(AKOrchestra *)orchestraToJoin
{
    orchestra = orchestraToJoin;
}

- (NSString *)stringForCSD
{
    NSMutableString *text = [NSMutableString stringWithString:@""];
    
    if ([_properties count] + [_noteProperties count] > 0 ) {
        [text appendString:@"\n;---- Inputs: Note Properties ----\n"];
        
        for (AKNoteProperty *prop in _noteProperties) {
            [text appendFormat:@"%@ = p%i\n", prop, prop.pValue];
        }
        [text appendString:@"\n;---- Inputs: Instrument Properties ----\n"];
        for (AKInstrumentProperty *prop in _properties) {
            [text appendString:[prop stringForCSDGetValue]];
        }
        [text appendString:@"\n;---- Opcodes ----\n"];
    }
    
    [text appendString:innerCSDRepresentation];
    
    if ([_properties count] > 0) {
        [text appendString:@"\n;---- Outputs ----\n"];
        for (AKInstrumentProperty *prop in _properties) {
            [text appendString:[prop stringForCSDSetValue]];
        }
    }
    return (NSString *)text;
}

- (NSString *)stopStringForCSD
{
    return [NSString stringWithFormat:@"i \"DeactivateInstrument\" 0 0.1 %i\n", _myID ];
}


- (void)playForDuration:(float)playDuration
{
    AKNote *myNote = [[AKNote alloc] initWithInstrument:self
                                            forDuration:playDuration];
    [myNote play];
}

- (void)play
{
    AKNote *note = [[AKNote alloc] initWithInstrument:self];
    [note play];
}

- (void)playNote:(AKNote *)note
{
    note.instrument = self;
    [note play];
}

- (void)playNote:(AKNote *)note afterDelay:(float)delay
{
    note.instrument = self;
    [note playAfterDelay:delay];
}

- (void)playPhrase:(AKPhrase *)phrase
{
    [phrase playUsingInstrument:self];
}


- (void)stop
{
    [[AKManager sharedManager] stopInstrument:self];
}

@end

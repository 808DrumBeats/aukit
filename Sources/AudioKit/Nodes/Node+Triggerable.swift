// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AVFoundation

/// To allow physical models to be triggered
public protocol Triggerable {
    func trigger()
}

extension Node where Self: Triggerable {
    /// Trigger the sound with current parameters
    ///
    public func trigger() {
        auBase.trigger()
    }
}

public protocol MIDITriggerable {
    /// Trigger the sound with a set of parameters
    ///
    /// - Parameters:
    ///   - note: MIDI note number
    ///   - velocity: Amplitude or volume expressed as a MIDI Velocity 0-127
    ///
    func trigger(note: MIDINoteNumber, velocity: MIDIVelocity)
}

extension Node where Self: MIDITriggerable {
    /// Trigger the sound with a set of parameters
    ///
    /// - Parameters:
    ///   - note: MIDI note number
    ///   - velocity: Amplitude or volume expressed as a MIDI Velocity 0-127
    ///
    public func trigger(note: MIDINoteNumber, velocity: MIDIVelocity = 127) {
        start()
        auBase.trigger(note: note, velocity: velocity)
    }
}

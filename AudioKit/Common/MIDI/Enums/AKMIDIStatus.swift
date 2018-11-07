//
//  AKMIDIStatusType.swift
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright © 2018 AudioKit. All rights reserved.
//

public struct AKMIDIStatus {
    public var byte: MIDIByte

    public init(statusType: AKMIDIStatusType, channel: MIDIChannel) {
        byte = MIDIByte(statusType.rawValue) << 4 + channel
    }

    public init(command: AKMIDISystemCommand) {
        byte = command.rawValue
    }

    public init?(byte: MIDIByte) {
        if let _ = AKMIDIStatusType(rawValue: Int(byte.highBit)) {
            self.byte = byte
        } else {
            return nil
        }
    }

    public var type: AKMIDIStatusType? {
        return AKMIDIStatusType(rawValue: Int(byte.highBit))
    }

    public var command: AKMIDISystemCommand? {
        return AKMIDISystemCommand(rawValue: byte)
    }
    
    public var channel: MIDIChannel? {
        if type == .systemCommand {
            return nil
        }
        return byte.lowBit
    }
}

/// Potential MIDI Status messages
///
/// - NoteOff:
///    something resembling a keyboard key release
/// - NoteOn:
///    triggered when a new note is created, or a keyboard key press
/// - PolyphonicAftertouch:
///    rare MIDI control on controllers in which every key has separate touch sensing
/// - ControllerChange:
///    wide range of control types including volume, expression, modulation
///    and a host of unnamed controllers with numbers
/// - ProgramChange:
///    messages are associated with changing the basic character of the sound preset
/// - ChannelAftertouch:
///    single aftertouch for all notes on a given channel (most common aftertouch type in keyboards)
/// - PitchWheel:
///    common keyboard control that allow for a pitch to be bent up or down a given number of semitones
/// - SystemCommand:
///    differ from system to system
///
public enum AKMIDIStatusType: Int {
    /// Note off is something resembling a keyboard key release
    case noteOff = 8
    /// Note on is triggered when a new note is created, or a keyboard key press
    case noteOn = 9
    /// Polyphonic aftertouch is a rare MIDI control on controllers in which
    /// every key has separate touch sensing
    case polyphonicAftertouch = 10
    /// Controller changes represent a wide range of control types including volume,
    /// expression, modulation and a host of unnamed controllers with numbers
    case controllerChange = 11
    /// Program change messages are associated with changing the basic character of the sound preset
    case programChange = 12
    /// A single aftertouch for all notes on a given channel
    /// (most common aftertouch type in keyboards)
    case channelAftertouch = 13
    /// A pitch wheel is a common keyboard control that allow for a pitch to be
    /// bent up or down a given number of semitones
    case pitchWheel = 14
    /// System commands differ from system to system
    case systemCommand = 15

    public var length: Int? {
        switch self {
        case .programChange, .channelAftertouch:
            return 2
        case .noteOff ,.noteOn, .controllerChange, .pitchWheel, .polyphonicAftertouch:
            return 3
        case .systemCommand:
            return nil
        }
    }

    public var description: String {
        switch self {
        case .noteOff:
            return "Note Off"
        case .noteOn:
            return "Note On"
        case .polyphonicAftertouch:
            return "Polyphonic Aftertouch / Pressure"
        case .controllerChange:
            return "Control Change"
        case .programChange:
            return "Program Change"
        case .channelAftertouch:
            return "Channel Aftertouch / Pressure"
        case .pitchWheel:
            return "Pitch Wheel"
        case .systemCommand:
            return "System Command"
        }
    }
}

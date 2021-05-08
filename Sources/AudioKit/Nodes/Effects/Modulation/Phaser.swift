// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// This is a stereo phaser, generated from Faust code taken from the Guitarix project.
public class Phaser: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "phas"
    public static let ComponentDescription = AudioComponentDescription(effect: "phas")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for notchMinimumFrequency
    public static let notchMinimumFrequencyDef = NodeParameterDef(
        identifier: "notchMinimumFrequency",
        name: "Notch Minimum Frequency",
        address: akGetParameterAddress("PhaserParameterNotchMinimumFrequency"),
        defaultValue: 100,
        range: 20 ... 5_000,
        unit: .hertz,
        flags: .default)

    /// Notch Minimum Frequency
    @Parameter(notchMinimumFrequencyDef) public var notchMinimumFrequency: AUValue

    /// Specification details for notchMaximumFrequency
    public static let notchMaximumFrequencyDef = NodeParameterDef(
        identifier: "notchMaximumFrequency",
        name: "Notch Maximum Frequency",
        address: akGetParameterAddress("PhaserParameterNotchMaximumFrequency"),
        defaultValue: 800,
        range: 20 ... 10_000,
        unit: .hertz,
        flags: .default)

    /// Notch Maximum Frequency
    @Parameter(notchMaximumFrequencyDef) public var notchMaximumFrequency: AUValue

    /// Specification details for notchWidth
    public static let notchWidthDef = NodeParameterDef(
        identifier: "notchWidth",
        name: "Between 10 and 5000",
        address: akGetParameterAddress("PhaserParameterNotchWidth"),
        defaultValue: 1_000,
        range: 10 ... 5_000,
        unit: .hertz,
        flags: .default)

    /// Between 10 and 5000
    @Parameter(notchWidthDef) public var notchWidth: AUValue

    /// Specification details for notchFrequency
    public static let notchFrequencyDef = NodeParameterDef(
        identifier: "notchFrequency",
        name: "Between 1.1 and 4",
        address: akGetParameterAddress("PhaserParameterNotchFrequency"),
        defaultValue: 1.5,
        range: 1.1 ... 4.0,
        unit: .hertz,
        flags: .default)

    /// Between 1.1 and 4
    @Parameter(notchFrequencyDef) public var notchFrequency: AUValue

    /// Specification details for vibratoMode
    public static let vibratoModeDef = NodeParameterDef(
        identifier: "vibratoMode",
        name: "Direct or Vibrato (default)",
        address: akGetParameterAddress("PhaserParameterVibratoMode"),
        defaultValue: 1,
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Direct or Vibrato (default)
    @Parameter(vibratoModeDef) public var vibratoMode: AUValue

    /// Specification details for depth
    public static let depthDef = NodeParameterDef(
        identifier: "depth",
        name: "Between 0 and 1",
        address: akGetParameterAddress("PhaserParameterDepth"),
        defaultValue: 1,
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Between 0 and 1
    @Parameter(depthDef) public var depth: AUValue

    /// Specification details for feedback
    public static let feedbackDef = NodeParameterDef(
        identifier: "feedback",
        name: "Between 0 and 1",
        address: akGetParameterAddress("PhaserParameterFeedback"),
        defaultValue: 0,
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Between 0 and 1
    @Parameter(feedbackDef) public var feedback: AUValue

    /// Specification details for inverted
    public static let invertedDef = NodeParameterDef(
        identifier: "inverted",
        name: "1 or 0",
        address: akGetParameterAddress("PhaserParameterInverted"),
        defaultValue: 0,
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// 1 or 0
    @Parameter(invertedDef) public var inverted: AUValue

    /// Specification details for lfoBPM
    public static let lfoBPMDef = NodeParameterDef(
        identifier: "lfoBPM",
        name: "Between 24 and 360",
        address: akGetParameterAddress("PhaserParameterLfoBPM"),
        defaultValue: 30,
        range: 24 ... 360,
        unit: .generic,
        flags: .default)

    /// Between 24 and 360
    @Parameter(lfoBPMDef) public var lfoBPM: AUValue

    // MARK: - Initialization

    /// Initialize this phaser node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - notchMinimumFrequency: Notch Minimum Frequency
    ///   - notchMaximumFrequency: Notch Maximum Frequency
    ///   - notchWidth: Between 10 and 5000
    ///   - notchFrequency: Between 1.1 and 4
    ///   - vibratoMode: Direct or Vibrato (default)
    ///   - depth: Between 0 and 1
    ///   - feedback: Between 0 and 1
    ///   - inverted: 1 or 0
    ///   - lfoBPM: Between 24 and 360
    ///
    public init(
        _ input: Node,
        notchMinimumFrequency: AUValue = notchMinimumFrequencyDef.defaultValue,
        notchMaximumFrequency: AUValue = notchMaximumFrequencyDef.defaultValue,
        notchWidth: AUValue = notchWidthDef.defaultValue,
        notchFrequency: AUValue = notchFrequencyDef.defaultValue,
        vibratoMode: AUValue = vibratoModeDef.defaultValue,
        depth: AUValue = depthDef.defaultValue,
        feedback: AUValue = feedbackDef.defaultValue,
        inverted: AUValue = invertedDef.defaultValue,
        lfoBPM: AUValue = lfoBPMDef.defaultValue
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.notchMinimumFrequency = notchMinimumFrequency
            self.notchMaximumFrequency = notchMaximumFrequency
            self.notchWidth = notchWidth
            self.notchFrequency = notchFrequency
            self.vibratoMode = vibratoMode
            self.depth = depth
            self.feedback = feedback
            self.inverted = inverted
            self.lfoBPM = lfoBPM
        }
        connections.append(input)
    }
}

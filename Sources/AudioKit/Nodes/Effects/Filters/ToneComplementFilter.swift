// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// A complement to the AKLowPassFilter.
public class ToneComplementFilter: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "aton"
    public static let ComponentDescription = AudioComponentDescription(effect: "aton")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for halfPowerPoint
    public static let halfPowerPointDef = NodeParameterDef(
        identifier: "halfPowerPoint",
        name: "Half-Power Point (Hz)",
        address: akGetParameterAddress("ToneComplementFilterParameterHalfPowerPoint"),
        defaultValue: 1_000.0,
        range: 12.0 ... 20_000.0,
        unit: .hertz,
        flags: .default)

    /// Half-Power Point in Hertz. Half power is defined as peak power / square root of 2.
    @Parameter(halfPowerPointDef) public var halfPowerPoint: AUValue

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - halfPowerPoint: Half-Power Point in Hertz. Half power is defined as peak power / square root of 2.
    ///
    public init(
        _ input: Node,
        halfPowerPoint: AUValue = halfPowerPointDef.defaultValue
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.halfPowerPoint = halfPowerPoint
        }
        connections.append(input)
    }
}

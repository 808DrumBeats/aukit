// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// A first-order recursive low-pass filter with variable frequency response.
public class ToneFilter: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "tone"
    public static let ComponentDescription = AudioComponentDescription(effect: "tone")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for halfPowerPoint
    public static let halfPowerPointDef = NodeParameterDef(
        identifier: "halfPowerPoint",
        name: "Half-Power Point (Hz)",
        address: akGetParameterAddress("ToneFilterParameterHalfPowerPoint"),
        defaultValue: 1_000.0,
        range: 12.0 ... 20_000.0,
        unit: .hertz,
        flags: .default)

    /// Response curve's half-power point, in Hertz. Half power is defined as peak power / root 2.
    @Parameter(halfPowerPointDef) public var halfPowerPoint: AUValue

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - halfPowerPoint: Response curve's half-power point, in Hertz. Half power is defined as peak power / root 2.
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

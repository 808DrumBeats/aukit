// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AVFoundation
import CAudioKit

/// Transient shaper
public class TransientShaper: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "trsh"
    public static let ComponentDescription = AudioComponentDescription(effect: "trsh")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for input amount
    public static let inputAmountDef = NodeParameterDef(
        identifier: "inputAmount",
        name: "Input",
        address: akGetParameterAddress("TransientShaperParameterInputAmount"),
        defaultValue: 0.0,
        range: -60.0 ... 30.0,
        unit: .decibels,
        flags: .default)

    /// Input Amount
    @Parameter(inputAmountDef) public var inputAmount: AUValue

    /// Specification details for attack amount
    public static let attackAmountDef = NodeParameterDef(
        identifier: "attackAmount",
        name: "Attack",
        address: akGetParameterAddress("TransientShaperParameterAttackAmount"),
        defaultValue: 0.0,
        range: -40.0 ... 40.0,
        unit: .decibels,
        flags: .default)

    /// Attack Amount
    @Parameter(attackAmountDef) public var attackAmount: AUValue

    /// Specification details for release amount
    public static let releaseAmountDef = NodeParameterDef(
        identifier: "releaseAmount",
        name: "Release",
        address: akGetParameterAddress("TransientShaperParameterReleaseAmount"),
        defaultValue: 0.0,
        range: -40.0 ... 40.0,
        unit: .decibels,
        flags: .default)

    /// Release Amount
    @Parameter(releaseAmountDef) public var releaseAmount: AUValue

    /// Specification details for output amount
    public static let outputAmountDef = NodeParameterDef(
        identifier: "outputAmount",
        name: "Output",
        address: akGetParameterAddress("TransientShaperParameterOutputAmount"),
        defaultValue: 0.0,
        range: -60.0 ... 30.0,
        unit: .decibels,
        flags: .default)

    /// Output Amount
    @Parameter(outputAmountDef) public var outputAmount: AUValue

    // MARK: - Initialization

    /// Initialize this delay node
    ///
    /// - Parameters:
    ///     - input: Input node to process
    ///     - attackAmount
    ///     - releaseAmount
    ///     - output
    public init(
        _ input: Node,
        inputAmount: AUValue = inputAmountDef.defaultValue,
        attackAmount: AUValue = attackAmountDef.defaultValue,
        releaseAmount: AUValue = releaseAmountDef.defaultValue,
        outputAmount: AUValue = outputAmountDef.defaultValue
    ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioNode = avAudioUnit

            self.internalAU = avAudioUnit.auAudioUnit as? AudioUnitType

            self.inputAmount = inputAmount
            self.attackAmount = attackAmount
            self.releaseAmount = releaseAmount
            self.outputAmount = outputAmount
        }

        connections.append(input)
    }

}

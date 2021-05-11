// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// AKStringResonator passes the input through a network composed of comb, 
/// low-pass and all-pass filters, similar to the one used in some versions of the 
/// Karplus-Strong algorithm, creating a string resonator effect. The fundamental frequency 
/// of the “string” is controlled by the fundamentalFrequency.  
/// This operation can be used to simulate sympathetic resonances to an input signal.
/// 
public class StringResonator: Node {

    let input: Node

    /// Connected nodes
    public var connections: [Node] { [input] }

    /// Underlying AVAudioNode
    public var avAudioNode = instantiate(effect: "stre")

    // MARK: - Parameters

    /// Specification details for fundamentalFrequency
    public static let fundamentalFrequencyDef = NodeParameterDef(
        identifier: "fundamentalFrequency",
        name: "Fundamental Frequency (Hz)",
        address: akGetParameterAddress("StringResonatorParameterFundamentalFrequency"),
        defaultValue: 100,
        range: 12.0 ... 10_000.0,
        unit: .hertz)

    /// Fundamental frequency of string.
    @Parameter(fundamentalFrequencyDef) public var fundamentalFrequency: AUValue

    /// Specification details for feedback
    public static let feedbackDef = NodeParameterDef(
        identifier: "feedback",
        name: "Feedback (%)",
        address: akGetParameterAddress("StringResonatorParameterFeedback"),
        defaultValue: 0.95,
        range: 0.0 ... 1.0,
        unit: .percent)

    /// Feedback amount (value between 0-1). A value close to 1 creates a slower decay and a more pronounced resonance. Small values may leave the input signal unaffected. Depending on the filter frequency, typical values are > .9.
    @Parameter(feedbackDef) public var feedback: AUValue

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - fundamentalFrequency: Fundamental frequency of string.
    ///   - feedback: Feedback amount (value between 0-1). A value close to 1 creates a slower decay and a more pronounced resonance. Small values may leave the input signal unaffected. Depending on the filter frequency, typical values are > .9.
    ///
    public init(
        _ input: Node,
        fundamentalFrequency: AUValue = fundamentalFrequencyDef.defaultValue,
        feedback: AUValue = feedbackDef.defaultValue
        ) {
        self.input = input

        setupParameters()

        self.fundamentalFrequency = fundamentalFrequency
        self.feedback = feedback
   }
}

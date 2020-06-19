// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit

/// Presets for the AKMandolin
public extension AKMandolin {

    /// Large Resonant Mandolin
    func presetLargeResonantMandolin() {
        detune = 0.503
        bodySize = 2.865
    }

    /// Preset with Strings pairs separated by an octave
    func presetOctaveUpMandolin() {
        detune = 1.996
        bodySize = 1.0
    }

    /// A mandolin that sounds a bit like an electric guitar
    func presetElectricGuitarMandolin() {
        detune = 0.996
        bodySize = 1.954
    }

    /// Small, distorted mandolin
    func presetSmallBodiedDistortedMandolin() {
        detune = 1.508
        bodySize = 0.375
    }

    /// A strangly tuned, psychedelic mandolin
    func presetAcidMandolin() {
        detune = 1.876
        bodySize = 2.948
    }

    /// Print out current values in case you want to save it as a preset
    func printCurrentValuesAsPreset() {
        AKLog("public func presetSomeNewMandolin() {")
        AKLog("    detune = \(String(format: "%0.3f", detune))")
        AKLog("    bodySize = \(String(format: "%0.3f", bodySize))")
        AKLog("}\n")
    }

}

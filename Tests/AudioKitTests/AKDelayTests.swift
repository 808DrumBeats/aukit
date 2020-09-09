// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKDelayTests: XCTestCase {

    func testDryWetMix() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDelay(input, time: 0.012_3, dryWetMix: 45.6)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testFeedback() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDelay(input, time: 0.012_3, feedback: 34.5)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testLowpassCutoff() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDelay(input, time: 0.012_3, lowPassCutoff: 1_234)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testParameters() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDelay(input, time: 0.012_3, feedback: 34.5, lowPassCutoff: 1_234, dryWetMix: 45.6)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testTime() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDelay(input, time: 0.012_3)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

}

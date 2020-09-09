// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

// TODO: Test was left out of old test suite.
#if false

class AKDynaRangeCompressorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Need to have a longer test duration to allow for envelope to progress
        duration = 1.0
        input.rampDuration = 0.0
        input.amplitude = 0.1
    }

    func testAttackTime() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input, ratio: 10, attackDuration: 21)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testDefault() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testParameters() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input,
                                      ratio: 10,
                                      threshold: -1,
                                      attackDuration: 21,
                                      releaseDuration: 22)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testRage() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input, ratio: 10, rage: 10)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testRatio() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input, ratio: 10)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testReleaseTime() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input, ratio: 10, releaseDuration: 22)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testThreshold() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKDynaRageCompressor(input, ratio: 10, threshold: -1)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

}

#endif

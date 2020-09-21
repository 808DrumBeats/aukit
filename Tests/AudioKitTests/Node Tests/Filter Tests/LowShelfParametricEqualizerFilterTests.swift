// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class LowShelfParametricEqualizerFilterTests: XCTestCase {

    func testCornerFrequency() {
        let engine = AudioEngine()
        let input = Oscillator()
        engine.output = LowShelfParametricEqualizerFilter(input, cornerFrequency: 500)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testDefault() {
        let engine = AudioEngine()
        let input = Oscillator()
        engine.output = LowShelfParametricEqualizerFilter(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testGain() {
        let engine = AudioEngine()
        let input = Oscillator()
        engine.output = LowShelfParametricEqualizerFilter(input, gain: 2)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testParameters() {
        let engine = AudioEngine()
        let input = Oscillator()
        engine.output = LowShelfParametricEqualizerFilter(input, cornerFrequency: 500, gain: 2, q: 1.414)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testQ() {
        let engine = AudioEngine()
        let input = Oscillator()
        engine.output = LowShelfParametricEqualizerFilter(input, q: 1.415)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }
}

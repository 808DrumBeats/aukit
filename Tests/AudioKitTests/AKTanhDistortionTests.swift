// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKTanhDistortionTests: XCTestCase {

    func testDefault() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKTanhDistortion(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testNegativeShapeParameter() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKTanhDistortion(input, negativeShapeParameter: 1)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testParameters() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKTanhDistortion(input, pregain: 4, postgain: 1, positiveShapeParameter: 1, negativeShapeParameter: 1)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testPositiveShapeParameter() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKTanhDistortion(input, positiveShapeParameter: 1)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testPostgain() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKTanhDistortion(input, postgain: 1)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testPregain() {
        let engine = AKEngine()
        let input = AKOscillator()
        engine.output = AKTanhDistortion(input, pregain: 4)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

}

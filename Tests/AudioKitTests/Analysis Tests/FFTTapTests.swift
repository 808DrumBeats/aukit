// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class FFTTapTests: XCTestCase {

    func testBasic() {
        let engine = AudioEngine()

        let sine = OperationGenerator {
            let s = Operation.sawtooth(frequency: 0.25, amplitude: 1, phase: 0) + 2
            return Operation.sineWave(frequency: 440 * s, amplitude: 1)
        }

        sine.start()

        var fftData: [Int] = []

        engine.output = sine

        let expect = expectation(description: "wait for amplitudes")
        let knownValues: [Int] = [42, 44, 46, 48, 50, 52, 54, 56, 58, 60]

        let tap = FFTTap(sine) { fft in
            let max: Float = fft.max() ?? 0.0
            let index = Int(fft.firstIndex(of: max) ?? 0)
            fftData.append(index)

            if fftData.count == knownValues.count {
                expect.fulfill()
            }
        }
        tap.start()

        let audio = engine.startTest(totalDuration: 2.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)

        wait(for: [expect], timeout: 5.0)

        for i in 0..<knownValues.count {
            XCTAssertEqual(fftData[i], knownValues[i])
        }
    }

}

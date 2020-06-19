// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit

class SquareWaveTests: AKTestCase {

    let square = AKOperationGenerator { _ in return AKOperation.squareWave() }

    override func setUp() {
        afterStart = { self.square.start() }
        duration = 1.0
    }

    func testDefault() {
        output = square
        AKTestMD5("8c93ddbc4ce8393a53d2a2c68ab45dca")
    }

}

import AudioKit
import AVFoundation
import XCTest

class AKPlayerTests: XCTestCase {

    // Because SPM doesn't support resources yet, render out a test file.
    func generateTestFile() -> URL {

        let osc = AKOscillator()
        let engine = AKEngine()
        engine.output = osc
        osc.start()

        let mgr = FileManager.default
        let url = mgr.temporaryDirectory.appendingPathComponent("test.aiff")
        try? mgr.removeItem(at: url)
        let file = try! AVAudioFile(forWriting: url, settings: AKSettings.audioFormat.settings)

        try! engine.renderToFile(file, duration: 1)
        print("rendered test file to \(url)")

        return url
    }

    func testBasic() {
        let url = generateTestFile()

        let file = try! AVAudioFile(forReading: url)

        let engine = AKEngine()
        let player = AKPlayer()
        engine.output = player

        let audio = engine.startTest(totalDuration: 2.0)
        player.scheduleFile(file, at: nil)
        player.play()
        audio.append(engine.render(duration: 2.0))
        engine.stop()

        testMD5(audio)
        // audition(audio)
    }

    func testLoop() {
        let url = generateTestFile()
        let file = try! AVAudioFile(forReading: url)
        let buffer = try! AVAudioPCMBuffer(file: file)!

        let engine = AKEngine()
        let player = AKPlayer()
        engine.output = player

        let audio = engine.startTest(totalDuration: 2.0)

        player.scheduleBuffer(buffer, at: nil, options: .loops)
        player.play()

        audio.append(engine.render(duration: 2.0))
        engine.stop()

        testMD5(audio)
        // audition(audio)
    }

    func testScheduleEarly() {

        let url = generateTestFile()

        let file = try! AVAudioFile(forReading: url)

        let player = AKPlayer()
        player.scheduleFile(file, at: nil)
    }
}

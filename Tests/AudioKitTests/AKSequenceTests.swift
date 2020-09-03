// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import XCTest
import AudioKit
import CAudioKit

class AKSequenceTests: XCTestCase {

    func testAdd() {
        var seq = AKSequence()

        seq.add(noteNumber: 60, position: 1.0, duration: 1.0)

        var newNote = AKSequenceNote()

        newNote.noteOn.status = AKSequence.noteOn
        newNote.noteOn.data1 = 60
        newNote.noteOn.data2 = 127
        newNote.noteOn.beat = 1.0

        newNote.noteOff.status = AKSequence.noteOff
        newNote.noteOff.data1 = 60
        newNote.noteOff.data2 = 127
        newNote.noteOff.beat = 2.0
        
        XCTAssertEqual(seq, AKSequence(notes: [newNote], events: []))
    }

    func testRemoveNote() {

        var seq = AKSequence()
        seq.add(noteNumber: 60, position: 0, duration: 0.1)
        seq.add(noteNumber: 62, position: 0.1, duration: 0.1)
        seq.add(noteNumber: 63, position: 0.2, duration: 0.1)
        seq.removeNote(at: 0.1)

        XCTAssertEqual(seq.notes.count, 2)
    }

    func testRemoveInstances() {

        var seq = AKSequence()
        seq.add(noteNumber: 60, position: 0, duration: 0.1)
        seq.add(noteNumber: 62, position: 0.1, duration: 0.1)
        seq.add(noteNumber: 63, position: 0.2, duration: 0.1)
        seq.removeAllInstancesOf(noteNumber: 63)

        XCTAssertEqual(seq.notes.count, 2)
        XCTAssertEqual(seq.notes[0].noteOn.data1, 60)
        XCTAssertEqual(seq.notes[1].noteOn.data1, 62)
    }

}

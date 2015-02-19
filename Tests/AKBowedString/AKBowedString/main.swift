//
//  main.swift
//  AudioKit
//
//  Created by Aurelius Prochazka and Nick Arner on 1/1/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import Foundation

let testDuration: Float = 4.0

class Instrument : AKInstrument {

    override init() {
        super.init()

        let note = Note()
        addNoteProperty(note.frequency)

        let envelope = AKLinearEnvelope(
            riseTime: 0.2.ak,
            decayTime: 0.2.ak,
            totalDuration: 0.5.ak,
            amplitude: 0.25.ak
        )
        connect(envelope)

        let bowedString = AKBowedString()
        bowedString.frequency = note.frequency
        bowedString.vibratoFrequency = 4.ak
        bowedString.vibratoAmplitude = 0.01.ak
        bowedString.amplitude = envelope
        connect(bowedString)

        enableParameterLog(
            "Frequency = ",
            parameter: bowedString.frequency,
            timeInterval:2
        )
        setAudioOutput(bowedString)
    }
}

class Note: AKNote {
    var frequency = AKNoteProperty(value: 220, minimum: 110, maximum: 880)
    override init() {
        super.init()
        addProperty(frequency)
    }
    convenience init(frequency startingFrequency: Float) {
        self.init()
        frequency.setValue(startingFrequency)
    }
}

AKOrchestra.testForDuration(testDuration)

let instrument = Instrument()
AKOrchestra.addInstrument(instrument)

let note1 = Note(frequency: 440)
note1.duration.setValue(0.50)
let note2 = Note(frequency: 550)
note2.duration.setValue(0.50)
let note3 = Note(frequency: 660)
note3.duration.setValue(0.50)

let phrase = AKPhrase()
phrase.addNote(note1, atTime:0.5)
phrase.addNote(note2, atTime:1.0)
phrase.addNote(note3, atTime:1.5)
phrase.addNote(note2, atTime:2.0)

instrument.playPhrase(phrase)


let manager = AKManager.sharedManager()
while(manager.isRunning) {} //do nothing
println("Test complete!")

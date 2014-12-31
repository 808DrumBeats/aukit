//
//  main.swift
//  AudioKit
//
//  Created by Nick Arner and Aurelius Prochazka on 12/3/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import Foundation

let testDuration: Float = 10.0

class Instrument : AKInstrument {

    override init() {
        super.init()

        let phasingControl = AKPhasor()
        phasingControl.frequency = 5.ak
        connect(phasingControl)

        let phasor = AKPhasor()
        phasor.frequency = phasingControl.scaledBy(880.ak)
        connect(phasor)
        connect(AKAudioOutput(audioSource:phasor))

        enableParameterLog(
            "Frequency = ",
            parameter: phasor.frequency,
            timeInterval:0.1
        )
    }
}

let instrument = Instrument()
AKOrchestra.addInstrument(instrument)
AKOrchestra.testForDuration(testDuration)

instrument.play()

while(AKManager.sharedManager().isRunning) {} //do nothing
println("Test complete!")

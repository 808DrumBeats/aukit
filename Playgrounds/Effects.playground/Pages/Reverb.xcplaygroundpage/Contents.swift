//: ## Simple Reverb
//: This is an implementation of Apple's simplest reverb which only allows you to set presets

import AudioKit

let file = try AVAudioFile(readFileName: playgroundAudioFiles[0])

let player = try AudioPlayer(file: file)
player.looping = true

var reverb = Reverb(player)
reverb.dryWetMix = 0.5

engine.output = reverb
try engine.start()

player.play()

//: User Interface Set up

class LiveView: View {

    override func viewDidLoad() {
        addTitle("Reverb")

        addView(Slider(property: "Mix", value: reverb.dryWetMix) { sliderValue in
            reverb.dryWetMix = sliderValue
        })

        let presets = ["Cathedral", "Large Hall", "Large Hall 2",
                       "Large Room", "Large Room 2", "Medium Chamber",
                       "Medium Hall", "Medium Hall 2", "Medium Hall 3",
                       "Medium Room", "Plate", "Small Room"]
        addView(PresetLoaderView(presets: presets) { preset in
            switch preset {
            case "Cathedral":
                reverb.loadFactoryPreset(.cathedral)
            case "Large Hall":
                reverb.loadFactoryPreset(.largeHall)
            case "Large Hall 2":
                reverb.loadFactoryPreset(.largeHall2)
            case "Large Room":
                reverb.loadFactoryPreset(.largeRoom)
            case "Large Room 2":
                reverb.loadFactoryPreset(.largeRoom2)
            case "Medium Chamber":
                reverb.loadFactoryPreset(.mediumChamber)
            case "Medium Hall":
                reverb.loadFactoryPreset(.mediumHall)
            case "Medium Hall 2":
                reverb.loadFactoryPreset(.mediumHall2)
            case "Medium Hall 3":
                reverb.loadFactoryPreset(.mediumHall3)
            case "Medium Room":
                reverb.loadFactoryPreset(.mediumRoom)
            case "Plate":
                reverb.loadFactoryPreset(.plate)
            case "Small Room":
                reverb.loadFactoryPreset(.smallRoom)
            default:
                break
            }
        })
    }

}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = LiveView()

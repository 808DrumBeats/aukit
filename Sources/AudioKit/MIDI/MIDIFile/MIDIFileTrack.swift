// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import Foundation

#if !os(tvOS)

public struct MIDIFileTrack {

    var chunk: MIDIFileTrackChunk

    public var channelEvents: [MIDIEvent] {
        return chunk.chunkEvents.compactMap({ MIDIEvent(fileEvent: $0) }).filter({ $0.status?.data != nil })
    }

    public var events: [MIDIEvent] {
        return chunk.chunkEvents.compactMap({ MIDIEvent(fileEvent: $0) })
    }

    public var metaEvents: [AKMIDIMetaEvent] {
        return chunk.chunkEvents.compactMap({ AKMIDIMetaEvent(fileEvent: $0) })
    }

    public var length: Double {
        return metaEvents.last?.positionInBeats ?? 0
    }

    public var name: String? {
        if let nameChunk = chunk.chunkEvents.first(where: { $0.typeByte == AKMIDIMetaEventType.trackName.rawValue }),
            let meta = AKMIDIMetaEvent(data: nameChunk.computedData) {
            return meta.name
        }
        return nil
    }

    init(chunk: MIDIFileTrackChunk) {
        self.chunk = chunk
    }
}

#endif
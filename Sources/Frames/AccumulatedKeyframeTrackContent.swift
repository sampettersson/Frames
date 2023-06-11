//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

struct AccumulatedKeyframeTrackContent<
    Value,
    Accumulated: KeyframeTrackContent,
    Next: KeyframeTrackContent
>: KeyframeTrackContent where Value: Animatable, Accumulated.Value == Value, Next.Value == Value {
    public typealias Value = Value
    
    var accumulated: Accumulated
    var next: Next
    
    init(accumulated: Accumulated, next: Next) {
        self.accumulated = accumulated
        self.next = next
    }
    
    var body: some KeyframeTrackContent {
        self
    }
}

extension AccumulatedKeyframeTrackContent: KeyframesTracks {
    var tracks: [any KeyframeTrackContent] {
        var allTracks: [any KeyframeTrackContent] = []
        
        if let accumulated = self.accumulated as? KeyframesTracks {
            accumulated.tracks.forEach { track in
                allTracks.append(track)
            }
        } else {
            allTracks.append(accumulated)
        }
        
        if let next = self.next as? KeyframesTracks {
            next.tracks.forEach { track in
                allTracks.append(track)
            }
        } else {
            allTracks.append(next)
        }
        
        return allTracks
    }
}

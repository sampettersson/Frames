//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

public struct KeyframeTimeline<Value, Content> where Value: Animatable, Content: Keyframes<Value> {
    var initialValue: Value
    var content: Content
    
    public init(
        initialValue: Value,
        @KeyframesBuilder<Value> content: () -> Content
    ) {
        self.initialValue = initialValue
        self.content = content()
    }
    
    var allTracks: [any KeyframeTrackContent] {
        if let track = content as? KeyframesTracks {
            return track.tracks
        }
        
        return []
    }
    
    public var duration: TimeInterval {
        allTracks.reduce(0) { partialResult, trackContent in
            if let duration = trackContent as? KeyframeDuration {
                return partialResult + duration.duration
            }
            
            return partialResult
        }
    }
    
    public func value(time: Double) -> Value {
        let splittedByCubicKeyframes = allTracks.split { content in
            content as? any CatmullRomSplineable == nil
        }
        
        let slice = splittedByCubicKeyframes.first!
        
        if let splineable = slice.first as? any CatmullRomSplineable {
            let function = splineable.spline(
                initialValue: self.initialValue,
                Array(slice) as! [any CatmullRomSplineable]
            )
            
            return function(time) as! Value
        }
        
        return initialValue
    }
}

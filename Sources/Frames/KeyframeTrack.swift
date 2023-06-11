//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation

public struct KeyframeTrack<Root, Value, Content> where Value == Content.Value, Content : KeyframeTrackContent {
    var content: Content
    
    init(content: Content) {
        self.content = content
    }
    
    public init(@KeyframeTrackContentBuilder<Root> content: () -> Content) where Root == Value {
        self.content = content()
    }
}

extension KeyframeTrack: Keyframes {
    public typealias Value = Value
    
    public var body: some Keyframes {
        self
    }
}

extension KeyframeTrack: KeyframesTracks {
    var tracks: [any KeyframeTrackContent] {
        if let inner = self.content as? KeyframesTracks {
            return inner.tracks
        }
        
        return [self.content]
    }
}

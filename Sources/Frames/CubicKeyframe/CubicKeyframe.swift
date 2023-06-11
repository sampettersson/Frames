//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI
import SpriteKit

public struct CubicKeyframe<Value> where Value : Animatable {
    let to: Value
    let duration: TimeInterval
    let startVelocity: Value?
    let endVelocity: Value?
    
    public init(
        _ to: Value,
        duration: TimeInterval,
        startVelocity: Value? = nil,
        endVelocity: Value? = nil
    ) {
        self.to = to
        self.duration = duration
        self.startVelocity = startVelocity
        self.endVelocity = endVelocity
    }
}

extension CubicKeyframe: KeyframeTrackContent {
    public typealias Value = Value
    
    public var body: some KeyframeTrackContent {
        self
    }
}

extension CubicKeyframe: KeyframeDuration {
    
}

protocol CatmullRomSplineable {
    func spline(
        initialValue: some Animatable,
        _ all: [CatmullRomSplineable]
    ) -> ((TimeInterval) -> any Animatable)
}

extension CubicKeyframe: CatmullRomSplineable {
    func spline(
        initialValue: some Animatable,
        _ all: [CatmullRomSplineable]
    ) -> ((TimeInterval) -> any Animatable) {
        let keyframes = all as! [CubicKeyframe<Value>]
        
        var currentTime: TimeInterval = 0
        
        let keyframeValues = [
            [(initialValue as! Value).animatableData],
            keyframes.map({ keyframe in
                keyframe.to.animatableData
            })
        ].flatMap { $0 }
        
        let times = [
            [0.0 as NSNumber],
            keyframes.map({ keyframe in
                let nextTime = currentTime + keyframe.duration
                currentTime += keyframe.duration
                return nextTime as NSNumber
            })
        ].flatMap { $0 }
        
        let sequence = SKKeyframeSequence(
            keyframeValues: keyframeValues,
            times: times
        )
        sequence.interpolationMode = .spline
        
        return { time in
            var value = keyframes.first!.to
            value.animatableData = sequence.sample(atTime: time) as! Value.AnimatableData
            
            return value
        }
    }
}

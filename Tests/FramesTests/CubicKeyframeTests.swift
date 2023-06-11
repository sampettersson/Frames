//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import XCTest
import SwiftUI
@testable import Frames

struct FrameSample: Equatable {
    static func == (lhs: FrameSample, rhs: FrameSample) -> Bool {
        lhs.time == rhs.time && lhs.value.rounded(.up) == rhs.value.rounded(.up)
    }
    
    let time: TimeInterval
    let value: Double
}

class CubicKeyframeTests: XCTestCase {
    @available(iOS 17, *)
    var swiftUISamples: [FrameSample] {
        let timeline = SwiftUI.KeyframeTimeline(initialValue: 0) {
            CubicKeyframe(20.0, duration: 1.5)
            CubicKeyframe(40.0, duration: 1.5)
            CubicKeyframe(45.0, duration: 1.5)
            CubicKeyframe(0.0, duration: 1.5)
        }
        
        let segmentDuration = 0.5
        let segments = Int(timeline.duration / segmentDuration)
        
        var samples: [FrameSample] = []
        var currentTime = 0.0
        
        for _ in 0...segments {
            samples.append(FrameSample(time: currentTime, value: timeline.value(time: currentTime)))
            currentTime += segmentDuration
        }
                
        return samples
    }
    
    var framesSamples: [FrameSample] {
        let timeline = Frames.KeyframeTimeline(initialValue: 0.0) {
            CubicKeyframe(20.0, duration: 1.5)
            CubicKeyframe(40.0, duration: 1.5)
            CubicKeyframe(45.0, duration: 1.5)
            CubicKeyframe(0.0, duration: 1.5)
        }
        
        let segmentDuration = 0.5
        let segments = Int(timeline.duration / segmentDuration)
        
        var samples: [FrameSample] = []
        var currentTime = 0.0
        
        for _ in 0...segments {
            samples.append(FrameSample(time: currentTime, value: timeline.value(time: currentTime)))
            currentTime += segmentDuration
        }
                
        return samples
    }

    @available(iOS 17, *)
    func testSamplesBeingEqual() {
        XCTAssertEqual(framesSamples, swiftUISamples)
    }
}

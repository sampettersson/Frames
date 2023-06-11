//
//  ContentView.swift
//  FramesDemo
//
//  Created by Sam Pettersson on 2023-06-11.
//

import SwiftUI
import Frames
import Charts

struct FrameValue<Value>: Identifiable {
    let time: TimeInterval
    let value: Value
    
    var id: TimeInterval {
        time
    }
}

struct ContentView: View {
    
    @State var trigger: Bool = false
    
    @available(iOS 17, *)
    var swiftUIData: [FrameValue<Double>] {
        let timeline = SwiftUI.KeyframeTimeline(initialValue: 0) {
            CubicKeyframe(20.0, duration: 1.5)
            CubicKeyframe(40.0, duration: 1.5)
            CubicKeyframe(45.0, duration: 1.5)
            CubicKeyframe(0.0, duration: 1.5)
        }
        
        let segmentDuration = 0.05
        let segments = Int(timeline.duration / segmentDuration)
        
        var resultingFrames: [FrameValue<Double>] = []
        var currentTime = 0.0
        
        for _ in 0...segments {
            resultingFrames.append(FrameValue(time: currentTime, value: timeline.value(time: currentTime)))
            currentTime += segmentDuration
        }
                
        return resultingFrames
    }
    
    var framesData: [FrameValue<Double>] {
        let timeline = Frames.KeyframeTimeline(initialValue: 0.0) {
            CubicKeyframe(20.0, duration: 1.5, startVelocity: 20.0)
            CubicKeyframe(40.0, duration: 1.5)
            CubicKeyframe(45.0, duration: 1.5)
            CubicKeyframe(0.0, duration: 1.5)
        }
        
        let segmentDuration = 0.005
        let segments = Int(timeline.duration / segmentDuration)
        
        var resultingFrames: [FrameValue<Double>] = []
        var currentTime = 0.0
        
        for _ in 0...segments {
            resultingFrames.append(FrameValue(time: currentTime, value: timeline.value(time: currentTime)))
            currentTime += segmentDuration
        }
                
        return resultingFrames
    }
    
    
    var body: some View {
        VStack {
            if #available(iOS 17, *) {
                Chart(swiftUIData) {
                    LineMark(
                        x: .value("Time", $0.time),
                        y: .value("Value", $0.value)
                    )
                }.overlay {
                    Chart(framesData) {
                        LineMark(
                            x: .value("Time", $0.time),
                            y: .value("Value", $0.value)
                        )
                    }.opacity(0.5).foregroundColor(.red)
                }
                .frame(height: 400)
            }
            
            KeyframeAnimator(initialValue: 0.0, trigger: trigger) { value in
                Text("Hello, world!").offset(x: value)
            } keyframes: { _ in
                CubicKeyframe(0.0, duration: 1.5)
                CubicKeyframe(20.0, duration: 1.5)
                CubicKeyframe(40.0, duration: 1.5)
            }
            
            Button("Animate") {
                trigger.toggle()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

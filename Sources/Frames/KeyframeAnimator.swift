//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

public struct KeyframeAnimator<Value, KeyframePath, Content, Trigger: Equatable>: View where Value == KeyframePath.Value, Value: Animatable, KeyframePath : Keyframes, Content : View {
    @State var startDate: Date? = nil
    var trigger: Trigger
    var initialValue: Value
    var keyframes: (Value) -> KeyframePath
    var content: (Value) -> Content
    
    @State var timeline: KeyframeTimeline<Value, KeyframePath>
    
    public init(
        initialValue: Value,
        trigger: Trigger,
        @ViewBuilder content: @escaping (Value) -> Content,
        @KeyframesBuilder<Value> keyframes: @escaping (Value) -> KeyframePath
    ) {
        self.initialValue = initialValue
        self.keyframes = keyframes
        self.trigger = trigger
        self.content = content
        self._timeline = .init(initialValue: KeyframeTimeline(initialValue: initialValue) {
            keyframes(initialValue)
        })
    }
    
    @available(iOS 15, *)
    func value(
        in context: TimelineViewDefaultContext,
        timeline: KeyframeTimeline<Value, KeyframePath>
    ) -> Value {
        if let startDate {
            let timeInterval = context.date.timeIntervalSince(startDate)
            
            if timeInterval >= 0.001 {
                return timeline.value(time: timeInterval)
            }
        }
        
        return initialValue
    }
    
    public var body: some View {
        if #available(iOS 15, *) {
            let _ = Self._printChanges()

            TimelineView(.animation(paused: startDate == nil)) { context in
                content(value(in: context, timeline: timeline))
            }.onChange(of: trigger) { newValue in
                startDate = Date()
            }
        }
    }
}

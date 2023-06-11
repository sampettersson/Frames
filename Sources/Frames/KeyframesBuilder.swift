//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

@resultBuilder
public struct KeyframesBuilder<Value> {
    public static func buildArray(
        _ components: [some KeyframeTrackContent<Value>]
    ) -> some KeyframeTrackContent<Value> {
        ArrayKeyframeTrackContent(components)
    }
    
    public static func buildBlock() -> some Keyframes<Value> {
        VoidKeyframes<Value>()
    }
    
    public static func buildBlock() -> some KeyframeTrackContent<Value> where Value : Animatable {
        VoidKeyframeTrackContent()
    }
    
    public static func buildEither<First, Second>(first component: First) -> KeyframeTrackContentBuilder<Value>.Conditional<Value, First, Second> where Value == First.Value, First : KeyframeTrackContent, Second : KeyframeTrackContent, First.Value == Second.Value {
        KeyframeTrackContentBuilder.Conditional(component)
    }
    
    public static func buildEither<First, Second>(second component: Second) -> KeyframeTrackContentBuilder<Value>.Conditional<Value, First, Second> where Value == First.Value, First : KeyframeTrackContent, Second : KeyframeTrackContent, First.Value == Second.Value {
        KeyframeTrackContentBuilder.Conditional(component)
    }
    
    public static func buildExpression<K>(
        _ expression: K
    ) -> K where Value == K.Value, K : KeyframeTrackContent {
        expression
    }
    
    public static func buildExpression<Content>(
        _ expression: Content
    ) -> Content where Value == Content.Value, Content : Keyframes {
        expression
    }
    
    public static func buildFinalResult<Content>(
        _ component: Content
    ) -> KeyframeTrack<Value, Value, Content> where Value == Content.Value, Content : KeyframeTrackContent {
        KeyframeTrack<Value, Value, Content>(content: component)
    }
    
    public static func buildFinalResult<Content>(_ component: Content) -> Content where Value == Content.Value, Content : Keyframes {
        component
    }
    
    public static func buildPartialBlock(
        accumulated: some KeyframeTrackContent<Value>,
        next: some KeyframeTrackContent<Value>
    ) -> some KeyframeTrackContent<Value> {
        return AccumulatedKeyframeTrackContent(accumulated: accumulated, next: next)
    }
    
    public static func buildPartialBlock(
        accumulated: some Keyframes<Value>,
        next: some Keyframes<Value>
    ) -> some Keyframes<Value> {
        return AccumulatedKeyframes(accumulated: accumulated, next: next)
    }
    
    public static func buildPartialBlock<Content>(first: Content) -> Content where Value == Content.Value, Content : Keyframes {
        first
    }
    
    public static func buildPartialBlock<K>(first: K) -> K where Value == K.Value, K : KeyframeTrackContent {
        first
    }
}

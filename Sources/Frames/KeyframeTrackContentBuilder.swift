//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

@resultBuilder
public struct KeyframeTrackContentBuilder<Value> where Value : Animatable {
    public static func buildArray(_ components: [some KeyframeTrackContent<Value>]) -> some KeyframeTrackContent<Value> {
        ArrayKeyframeTrackContent(components)
    }
    
    public static func buildBlock() -> some KeyframeTrackContent<Value> {
        VoidKeyframeTrackContent()
    }
    
    static func buildEither<First, Second>(first component: First) -> KeyframeTrackContentBuilder<Value>.Conditional<Value, First, Second> where Value == First.Value, First : KeyframeTrackContent, Second : KeyframeTrackContent, First.Value == Second.Value {
        Conditional(component)
    }
    
    static func buildEither<First, Second>(second component: Second) -> KeyframeTrackContentBuilder<Value>.Conditional<Value, First, Second> where Value == First.Value, First : KeyframeTrackContent, Second : KeyframeTrackContent, First.Value == Second.Value {
        Conditional(component)
    }
    
    public static func buildExpression<K>(_ expression: K) -> K where Value == K.Value, K : KeyframeTrackContent {
        expression
    }
    
    public static func buildPartialBlock(
        accumulated: some KeyframeTrackContent<Value>,
        next: some KeyframeTrackContent<Value>
    ) -> some KeyframeTrackContent<Value> {
        AccumulatedKeyframeTrackContent(accumulated: accumulated, next: next)
    }
    
    public static func buildPartialBlock<K>(first: K) -> K where Value == K.Value, K : KeyframeTrackContent {
        first
    }
}

extension KeyframeTrackContentBuilder {
    public struct Conditional<Value, First, Second> where Value == First.Value, First : KeyframeTrackContent, Second : KeyframeTrackContent, First.Value == Second.Value {
        
        init(_ first: First) {
            
        }
        
        init(_ second: Second) {
            
        }
    }
}

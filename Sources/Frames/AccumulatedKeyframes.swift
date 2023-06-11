//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

struct AccumulatedKeyframes<
    Value,
    Accumulated: Keyframes,
    Next: Keyframes
>: Keyframes where Accumulated.Value == Value, Next.Value == Value {
    public typealias Value = Value
    
    var accumulated: Accumulated
    var next: Next
    
    init(accumulated: Accumulated, next: Next) {
        self.accumulated = accumulated
        self.next = next
    }
    
    var body: some Keyframes {
        self
    }
}

//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

struct ArrayKeyframeTrackContent<
    Value,
    Content: KeyframeTrackContent
>: KeyframeTrackContent where Value: Animatable, Content.Value == Value {
    public typealias Value = Value
    
    var contents: [Content]
    
    public init(_ contents: [Content]) {
        self.contents = contents
    }
    
    var body: some KeyframeTrackContent {
        self
    }
}

//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

struct VoidKeyframeTrackContent<Value>: KeyframeTrackContent where Value: Animatable {
    typealias Value = Value
    
    var body: some KeyframeTrackContent {
        self
    }
}

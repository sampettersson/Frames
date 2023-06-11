//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

extension Double: Animatable {
    public var animatableData: Double {
        get {
            self
        }
        set {
            self = newValue
        }
    }
}

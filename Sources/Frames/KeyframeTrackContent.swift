//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation
import SwiftUI

public protocol KeyframeTrackContent<Value> {
    associatedtype Body : KeyframeTrackContent
    associatedtype Value : Animatable = Self.Body.Value
    var body: Self.Body { get }
}

protocol KeyframeDuration {
    var duration: TimeInterval { get }
}

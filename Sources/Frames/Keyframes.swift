//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation

public protocol Keyframes<Value> {
    associatedtype Body : Keyframes
    associatedtype Value = Self.Body.Value
    var body: Self.Body { get }
}

protocol KeyframesTracks {
    var tracks: [any KeyframeTrackContent] { get }
}

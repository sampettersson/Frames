//
//  File.swift
//  
//
//  Created by Sam Pettersson on 2023-06-11.
//

import Foundation

struct VoidKeyframes<Value>: Keyframes {
    typealias Value = Value
    
    var body: some Keyframes {
        self
    }
}

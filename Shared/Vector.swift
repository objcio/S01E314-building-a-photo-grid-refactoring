//
//  Vector.swift
//  Photos
//
//  Created by Chris Eidhof on 23.06.22.
//

import SwiftUI

protocol Vector {
    var first: CGFloat { get }
    var second: CGFloat { get }
    init(_ first: CGFloat, _ second: CGFloat)
}

extension CGPoint: Vector {
    var first: CGFloat { x }
    var second: CGFloat { y }
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(x: first, y: second)
    }
}

extension Vector {
    static func -(lhs: Self, rhs: Vector) -> Self {
        .init(lhs.first-rhs.first, lhs.second-rhs.second)
    }
    
    static func +(lhs: Self, rhs: Vector) -> Self {
        .init(lhs.first+rhs.first, lhs.second+rhs.second)
    }
    
    static func /(lhs: Self, rhs: CGFloat) -> Self {
        .init(lhs.first/rhs, lhs.second/rhs)
    }
    
    static func *(lhs: Self, rhs: CGFloat) -> Self {
        .init(lhs.first*rhs, lhs.second*rhs)
    }
    
    func dot(_ rhs: Vector) -> CGFloat {
        first*rhs.first + second*rhs.second
    }
    
    var length: CGFloat {
        sqrt(first*first + second*second)
    }
    
    var normalized: Self {
        let length = self.length
        return Self(first/length, second/length)
    }
    
    init<V: Vector>(_ other: V) {
        self.init(other.first, other.second)
    }
}

extension CGSize: Vector {
    var first: CGFloat { width }
    var second: CGFloat { height }
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(width: first, height: second)
    }
    
}

extension CGRect {
    var center: CGPoint { CGPoint(x: midX, y: midY) }
}

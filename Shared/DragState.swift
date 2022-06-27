//
//  DragState.swift
//  Photos
//
//  Created by Chris Eidhof on 24.06.22.
//

import Foundation
import SwiftUI

struct DragState {
    var value: DragGesture.Value
    var detailPosition: CGPoint
    
    var velocity: CGSize = .zero
    
    var target: CGPoint?
    
    mutating func update(_ newValue: DragGesture.Value) {
        let interval = newValue.time.timeIntervalSince(value.time)
        velocity = (newValue.translation - value.translation) / interval
        value = newValue
    }
    
    var currentPosition: CGPoint {
        detailPosition + value.translation
    }
    
    var directionToTarget: CGPoint? {
        target.map { $0 - currentPosition }
    }
    
    var shouldClose: Bool {
        velocity.height > 0
    }
    
    var initialVelocity: CGFloat? {
        guard let d = directionToTarget else { return nil }
        let projectedVelocityLength = velocity.dot(d) / d.length
        let normalizedProjectedVelocity = projectedVelocityLength / d.length
        return normalizedProjectedVelocity
    }
}

extension DragState: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Line(start: value.location, end: value.location + velocity)
                .foregroundColor(.orange)
            if let d = directionToTarget {
                Line(start: value.location, end: value.location + d)
                    .foregroundColor(.blue)
                let initial = d * initialVelocity!
                Line(start: value.location, end: value.location + initial)
                    .foregroundColor(.green)
            }
        }
    }
}

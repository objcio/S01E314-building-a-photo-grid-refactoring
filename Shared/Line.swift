//
//  Line.swift
//  Photos
//
//  Created by Chris Eidhof on 23.06.22.
//

import SwiftUI

struct LineShape: Shape {
    var start: CGPoint
    var end: CGPoint
    
    public var angle: Angle {
        let diff = end - start
        return Angle(radians: atan2(diff.y, diff.x))
    }

    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
    }
}

struct RightArrow: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.minY)
        return Path { p in
            p.move(to: start)
            p.addLines([
                CGPoint(x: rect.maxX, y: rect.midY),
                CGPoint(x: rect.minX, y: rect.maxY),
                start
            ])
        }
    }
}


struct Line: View {
    var start: CGPoint
    var end: CGPoint
    var lineWidth: CGFloat = 2
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            let line = LineShape(start: start, end: end)
            
            line
                .stroke(lineWidth: lineWidth)
            RightArrow()
                .fill()
                .frame(width: 10, height: 10)
                .rotationEffect(line.angle)
                .offset(x: end.x-5, y: end.y-5)
            
        }
    }
}

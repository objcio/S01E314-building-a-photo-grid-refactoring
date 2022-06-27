//
//  DetailView.swift
//  Photos
//
//  Created by Chris Eidhof on 24.06.22.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var detail: Int
    var namespace: Namespace.ID
    var centerInGrid: CGPoint
    @Binding var dragScale: CGFloat
    var slowAnimations: Bool
    var close: () -> ()
    @State private var detailCenter: CGPoint = .zero
    @State private var dragState: DragState?
    @Namespace private var dummyNS

    var detailGesture: some Gesture {
        let tap = TapGesture().onEnded {
            close()
        }
        let drag = DragGesture(coordinateSpace: .global).onChanged { value in
            if dragState == nil {
                dragState = DragState(value: value, detailPosition: detailCenter)
            } else {
                dragState!.update(value)
            }
        }.onEnded { value in
            guard var d = dragState else { return }
            d.target = d.shouldClose ? centerInGrid : detailCenter
            withAnimation(.interpolatingSpring(mass: 5, stiffness: 200, damping: 100, initialVelocity: d.initialVelocity ?? 0).speed(slowAnimations ? 0.2 : 1)) {
                dragState = nil
                if d.shouldClose {
                    close()
                }
            }
        }
        
        return drag.simultaneously(with: tap)
    }
    
    var offset: CGSize {
        dragState?.value.translation ?? .zero
    }
    

    var body: some View {
        ZStack {
            TransitionReader { active in
                Image("beach_\(detail)")
                    .resizable()
                    .mask {
                        Rectangle().aspectRatio(1, contentMode: active ? .fit : .fill)
                    }
                    .matchedGeometryEffect(id: detail, in: active ? namespace : dummyNS, isSource: false)
                    .aspectRatio(contentMode: .fit)
                    .offset(offset)
                    .background(GeometryReader { proxy in
                        Color.clear.onAppearOrChange(of: proxy.frame(in: .global).center) { detailCenter = $0 }
                    })
                    .scaleEffect(active ? 1 : dragScale)
                    .gesture(detailGesture)
            }
        }
        .onChange(of: offset.height) { height in
            dragScale = {
                guard height > 0 else { return 1 }
                return 1 - height/1000
            }()
        }
        .transition(.modifier(active: TransitionActive(active: true), identity: TransitionActive(active: false)))

    }
}

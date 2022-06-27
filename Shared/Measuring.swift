//
//  Measuring.swift
//  Photos
//
//  Created by Chris Eidhof on 24.06.22.
//

import Foundation
import SwiftUI

struct GridKey: PreferenceKey {
    static var defaultValue: CGPoint?
    static func reduce(value: inout CGPoint?, nextValue: () -> CGPoint?) {
        value = value ?? nextValue()
    }
}

extension View {
    func measureGridCell(id: Int, selected: Bool) -> some View {
        background {
            if selected {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: GridKey.self, value: proxy.frame(in: .global).center)
                }
            }
        }
    }
    
    func onAppearOrChange<Value: Equatable>(of value: Value, perform: @escaping (Value) -> ()) -> some View {
        self.onChange(of: value) { perform($0) }
            .onAppear { perform(value) }
    }
}

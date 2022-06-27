//
//  GridView.swift
//  Photos
//
//  Created by Chris Eidhof on 24.06.22.
//

import Foundation
import SwiftUI

struct GridView: View {
    @Binding var detail: Int?
    var namespace: Namespace.ID
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
                ForEach(1..<11) { ix in
                    Image("beach_\(ix)")
                        .resizable()
                        .measureGridCell(id: ix, selected: ix == detail)
                        .matchedGeometryEffect(id: ix, in: namespace)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            detail = ix
                        }
                }
            }
        }
    }
}

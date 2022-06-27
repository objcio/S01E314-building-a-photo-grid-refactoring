// Photos are from https://unsplash.com

import SwiftUI

struct PhotosView: View {
    @State private var detail: Int? = nil
    @State private var slowAnimations = false
    @State private var dragScale: CGFloat = 1
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            Toggle("Slow Animations", isOn: $slowAnimations)
            GridView(detail: $detail, namespace: namespace)
                .opacity(gridOpacity)
                .animation(animation, value: gridOpacity == 0)
                .overlayPreferenceValue(GridKey.self) { center in
                    if let d = detail, let c = center {
                        DetailView(detail: d, namespace: namespace, centerInGrid: c, dragScale: $dragScale, slowAnimations: slowAnimations, close: { detail = nil })
                            .zIndex(2)
                            .id(detail)

                    }
                }
            .animation(animation, value: detail)
        }
    }
    
    var animation: Animation {
        .default.speed(slowAnimations ? 0.2 : 1)
    }
    
    var gridOpacity: CGFloat {
        guard detail != nil else { return 1 }
        return (1 - dragScale) * 1.3
    }
}

struct ContentView: View {
    var body: some View {
        PhotosView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

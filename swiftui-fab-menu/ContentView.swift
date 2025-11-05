//
//  ContentView.swift
//  swiftui-fab-menu
//
//  Created by HANYU, Koji on 2025/11/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EditView()
                .tabItem {
                    Label("Edit", systemImage: "pencil")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}

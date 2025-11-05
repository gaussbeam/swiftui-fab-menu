//
//  SettingsView.swift
//  swiftui-fab-menu
//
//  Created by HANYU, Koji on 2025/11/05.
//

import SwiftUI

struct SettingsView: View {
    @State private var showAlert = false
    @State private var isExpanding = false

    var body: some View {
        ZStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)

            FABMenu(
                type: .single(
                    FABAction(
                        title: "Settings",
                        iconName: "gearshape",
                        action: { showAlert = true }
                    )
                ),
                isExpanding: $isExpanding
            )
        }
        .alert("Button Clicked", isPresented: $showAlert) {
            Button("OK") {
                showAlert = false
            }
        } message: {
            Text("Settings button was clicked")
        }
    }
}

#Preview {
    SettingsView()
}

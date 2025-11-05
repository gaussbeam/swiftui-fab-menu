//
//  EditView.swift
//  swiftui-fab-menu
//
//  Created by HANYU, Koji on 2025/11/05.
//

import SwiftUI

struct EditView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isExpanding = false

    var body: some View {
        ZStack {
            Text("Edit")
                .font(.largeTitle)
                .fontWeight(.bold)

            FABMenu(
                type: .menu(
                    title: "Edit",
                    iconName: "pencil",
                    actions: [
                        FABAction(
                            title: "Edit draft",
                            iconName: "text.document",
                            action: {
                                alertMessage = "Edit draft button was clicked"
                                showAlert = true
                            }
                        ),
                        FABAction(
                            title: "Create new",
                            iconName: "square.and.pencil",
                            action: {
                                alertMessage = "Create new button was clicked"
                                showAlert = true
                            }
                        )
                    ]
                ),
                isExpanding: $isExpanding
            )
        }
        .alert("Button Clicked", isPresented: $showAlert) {
            Button("OK") {
                showAlert = false
            }
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview("Glass Style", traits: .fixedLayout(width: 375, height: 812)) {
    @Previewable @State var isExpanding = false

    ZStack {
        Text("Edit")
            .font(.largeTitle)
            .fontWeight(.bold)

        FABMenu(
            type: .menu(
                title: "Edit",
                iconName: "pencil",
                actions: [
                    FABAction(
                        title: "Edit draft",
                        iconName: "text.document",
                        action: {}
                    ),
                    FABAction(
                        title: "Create new",
                        iconName: "square.and.pencil",
                        action: {}
                    )
                ]
            ),
            isExpanding: $isExpanding,
            forceAppearance: .glass
        )
    }
}

#Preview("Shadow Style", traits: .fixedLayout(width: 375, height: 812)) {
    @Previewable @State var isExpanding = false

    ZStack {
        Text("Edit")
            .font(.largeTitle)
            .fontWeight(.bold)

        FABMenu(
            type: .menu(
                title: "Edit",
                iconName: "pencil",
                actions: [
                    FABAction(
                        title: "Edit draft",
                        iconName: "text.document",
                        action: {}
                    ),
                    FABAction(
                        title: "Create new",
                        iconName: "square.and.pencil",
                        action: {}
                    )
                ]
            ),
            isExpanding: $isExpanding,
            forceAppearance: .shadow
        )
    }
}

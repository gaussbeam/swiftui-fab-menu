//
//  FABMenu.swift
//  swiftui-fab-menu
//
//  Created by HANYU, Koji on 2025/11/05.
//

import SwiftUI

/// FAB（Floating Action Button）のアクションを表す構造体
struct FABAction: Identifiable {
    let id = UUID()
    let title: String?
    let iconName: String
    let action: () -> Void
}

/// FABの動作タイプ
enum FABType {
    case single(FABAction)
    case menu(title: String?, iconName: String, actions: [FABAction])
}

/// FABの見た目
/// - Note: iOS18以下の場合、この設定によらず常に.shadowが適用される
enum FABAppearance {
    /// Liquid Glassスタイル(iOS 26+ only)
    case glass
    /// 白背景+影のスタイル
    case shadow
}

/// FABメニュー。画面右下に自動配置される
///
/// - Note: 他のコンテンツの上に表示するため、ZStackで重ねて使用する
///
/// 使用例:
/// ```swift
/// ZStack {
///     // メインコンテンツ
///     Text("Main Content")
///
///     // FABを上に重ねる
///     FABMenu(
///         type: .menu(
///             title: "Add",
///             iconName: "plus",
///             actions: [
///                 FABAction(title: "New", iconName: "doc", action: { ... })
///             ]
///         ),
///         isExpanding: $isExpanding
///     )
/// }
/// ```
struct FABMenu: View {
    let type: FABType
    @Binding var isExpanding: Bool
    /// スタイル強制指定用（Optional）
    /// - Note: アプリでも動作はするが、プレビュー確認の簡便化が目的
    var forceAppearance: FABAppearance? = nil

    var body: some View {
        fabContent
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 16.0)
            .padding(.bottom, 16.0)
    }

    @ViewBuilder
    private var fabContent: some View {
        switch type {
        case .single(let action):
            FloatingButton(action: action, forceAppearance: forceAppearance)

        case .menu(let title, let iconName, let actions):
            VStack(alignment: .trailing, spacing: 12.0) {
                if isExpanding {
                    ForEach(actions) { action in
                        FloatingButton(action: action, forceAppearance: forceAppearance)
                    }
                    closeButton
                } else {
                    openButton(title: title, iconName: iconName)
                }
            }
            .animation(.bouncy, value: isExpanding)
        }
    }

    // MARK: --- 展開用ボタン

    private func openButton(title: String?, iconName: String) -> some View {
        FloatingButton(
            action: FABAction(
                title: title,
                iconName: iconName,
                action: {
                    isExpanding.toggle()
                }
            ), forceAppearance: forceAppearance
        )
    }

    private var closeButton: some View {
        FloatingButton(
            action: FABAction(
                title: nil,
                iconName: "xmark",
                action: {
                    isExpanding.toggle()
                }
            ),
            forceAppearance: forceAppearance
        )
    }
}

/// FABの個別ボタンビュー
fileprivate struct FloatingButton: View {
    let action: FABAction
    /// Previewで確認しやすいように、見た目のスタイルを強制的に指定できる
    /// - Note: `.glass`の指定はiOS 26以上でのみ動作する
    var forceAppearance: FABAppearance? = nil

    private let fabPadding = EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0)

    var body: some View {
        let appearance = forceAppearance ?? .glass

        if #available(iOS 26.0, *), appearance == .glass {
            buttonContent.buttonStyle(.glass)
        } else {
            buttonContent
                .padding(fabPadding) // .shadowの場合、再度paddingを設定しないと正しく表示されない
                .background {
                    RoundedRectangle(cornerRadius: 32.0)
                        .fill(.white)
                        .shadow(color: Color(.gray), radius: 2.5)
                }
        }
    }

    private var buttonContent: some View {
        Button {
            action.action()
        } label: {
            HStack(spacing: 4.0) {
                Image(systemName: action.iconName)
                    .font(.system(size: 24.0, weight: .semibold))
                if let title = action.title {
                    Text(title)
                }
            }
            .padding(fabPadding)
        }
        .tint(.blue)
    }
}

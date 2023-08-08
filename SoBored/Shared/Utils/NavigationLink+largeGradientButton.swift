//
//  NavigationLink+largeBlueButton.swift
//  SoBored
//
//  Created by Yash Shah on 03/11/2022.
//

import SwiftUI

extension View {
    func largeGradientButton(invertedGradient: Bool = false) -> some View {
        self
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .font(
                .system(.title2, design: .rounded)
                .weight(.medium)
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background {
                LinearGradient(
                    colors: [.indigo, .blue, .cyan],
                    startPoint: invertedGradient ? .topTrailing : .topLeading,
                    endPoint: invertedGradient ? .bottomLeading : .bottomTrailing
                ).opacity(0.75)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(
                        LinearGradient(
                            colors: [.indigo, .blue, .cyan],
                            startPoint: !invertedGradient ? .topTrailing : .topLeading,
                            endPoint: !invertedGradient ? .bottomLeading : .bottomTrailing
                        ).opacity(0.75)
                    )
            }
            .shadow(
                radius: 5,
                x: 0,
                y: invertedGradient ? 2.5 : -2.5
            )
    }
}

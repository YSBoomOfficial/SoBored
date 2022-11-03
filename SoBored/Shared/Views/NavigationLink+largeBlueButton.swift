//
//  NavigationLink+largeBlueButton.swift
//  SoBored
//
//  Created by Yash Shah on 03/11/2022.
//

import SwiftUI

extension NavigationLink {
    func largeBlueButton() -> some View {
        self
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.large)
            .tint(.blue.opacity(0.75))
            .font(.title2)
    }
}

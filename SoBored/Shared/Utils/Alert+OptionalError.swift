//
//  Alert+OptionalError.swift
//  SoBored
//
//  Created by Yash Shah on 10/10/2022.
//

import SwiftUI

extension View {
	func alert(_ title: String, error: Binding<Error?>, actions: () -> some View, message: () -> some View) -> some View {
		alert(
			title, isPresented: .init(
				get: { error.wrappedValue != nil },
				set: { _ in error.wrappedValue = nil }
			),
			actions: actions,
			message: message
		)
	}
}


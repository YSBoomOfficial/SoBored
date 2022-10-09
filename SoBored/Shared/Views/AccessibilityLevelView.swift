//
//  AccessibilityLevelView.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct AccessibilityLevelView: View {
	let level: ActivityItem.AccessibilityLevel

	var body: some View {
		Label {
			switch level {
				case .easy: Text("An easy task")
				case .medium: Text("A moderate task")
				case .hard: Text("A challenging task")
			}
		} icon: {
			Image(systemName: "square.fill")
				.foregroundColor(
					level == .easy ? .green
					: level == .medium ? .yellow
					: .red
				)
		}
	}
}

struct AccessibilityLevelView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			ForEach(ActivityItem.AccessibilityLevel.allCases) {
				AccessibilityLevelView(level: $0)
			}
		}
	}
}

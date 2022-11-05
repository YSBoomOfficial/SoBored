//
//  AccessibilityLevelView.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct AccessibilityLevelView: View {
	let level: ActivityItem.AccessibilityLevel

    var title: String {
        switch level {
            case .unspecified: return "???"
            case .easy: return "An easy task"
            case .medium: return "A moderate task"
            case .hard: return "A challenging task"
        }
    }

    var squareColor: Color {
        switch level {
            case .unspecified: return .label
            case .easy: return .green
            case .medium: return .yellow
            case .hard: return .red
        }
    }

	var body: some View {
		Label {
            Text(title)
		} icon: {
			Image(systemName: "square.fill")
				.foregroundColor(squareColor)
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

//
//  CustomActivitySearchView.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct CustomActivitySearchView: View {
	@StateObject private var vm = CustomActivitySearchViewModel()

	var body: some View {
		Form {
			Section {
				activityTypePicker
				participantsSlider
				pricePicker
				accessibilityLevelPicker
			}

			NavigationLink("Find Activity") {
                ActivityView(
                    activity: vm.activity,
                    error: vm.error
                ).task { await vm.fetch() }
			}
            .foregroundColor(.blue)
		}
		.navigationTitle("Custom Search")
	}
}

struct CustomActivitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomActivitySearchView()
                .preferredColorScheme(.dark)
        }
    }
}

fileprivate extension CustomActivitySearchView {
    var activityTypePicker: some View {
        Picker("Activity Type", selection: $vm.activityType) {
            ForEach(ActivityItem.ActivityType.allCases) { type in
                ActivityTypeLabel(type: type).tag(type)
            }
        }
    }

    var participantsSlider: some View {
        VStack(alignment: .leading) {
            Text("Number of participants: \(vm.participants, format: .number)")
            Slider(value: $vm.participants, in: 1...10, step: 1, label: EmptyView.init) {
                Text("1")
            } maximumValueLabel: {
                Text("10")
            }
        }
    }

    var pricePicker: some View {
        VStack(alignment: .leading) {
            Text("Price")
            Picker("Price", selection: $vm.activityCost) {
                ForEach(ActivityItem.Cost.allCases) {
                    Text($0.rawValue.capitalized).tag($0)
                }
            }.pickerStyle(.segmented)
        }
    }

    var accessibilityLevelPicker: some View {
        VStack(alignment: .leading) {
            Text("Task Difficulty")
            Picker("Task Difficulty", selection: $vm.accessibilityLevel) {
                ForEach(ActivityItem.AccessibilityLevel.allCases) {
                    Text($0.rawValue.capitalized).tag($0)
                }
            }.pickerStyle(.segmented)
        }
    }
}

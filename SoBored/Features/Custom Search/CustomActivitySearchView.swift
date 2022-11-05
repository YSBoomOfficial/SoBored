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

            Section {
                NavigationLink("Find Activity") {
                    ActivityView(
                        activity: vm.activity,
                        error: vm.error
                    ).task { await vm.fetch() }
                }
                .foregroundColor(.blue)
            } footer: {
                searchFooterView
            }
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
            Text("Number of participants: \(vm.participants > 0 ? String(Int(vm.participants)) : "Any")")
            Slider(value: $vm.participants, in: 0...10, step: 1, label: EmptyView.init) {
                Text(vm.participants > 0 ? "1" : "Any")
            } maximumValueLabel: {
                Text("10")
            }
        }
    }

    var pricePicker: some View {
        VStack(alignment: .leading) {
            Text("Price")
            Picker("Price", selection: $vm.activityCost) {
                ForEach(ActivityItem.Cost.allCases) { costType in
                    Text(costType.title).tag(costType)
                }
            }.pickerStyle(.segmented)
        }
    }

    var accessibilityLevelPicker: some View {
        VStack(alignment: .leading) {
            Text("Task Difficulty")
            Picker("Task Difficulty", selection: $vm.accessibilityLevel) {
                ForEach(ActivityItem.AccessibilityLevel.allCases) {
                    Text($0.title).tag($0)
                }
            }.pickerStyle(.segmented)
        }
    }

    @ViewBuilder
    var searchFooterView: some View {
        if vm.isEqualToBaseURL {
            VStack(alignment: .leading) {
                Text("Specifying **Any** for all parameters is the same as using the **Any Random Activity** button on the First Screen")
            }
        }
    }
}

//
//  ActivityView.swift
//  SoBored
//
//  Created by Yash Shah on 05/10/2022.
//

import SwiftUI

struct ActivityView: View {
	@Environment(\.dismiss) var dismiss

	let activity: ActivityItem?
    let error: NetworkingManager.NetworkingError?

	var body: some View {
		ZStack {
			Color.systemBackground.ignoresSafeArea()

			if activity == nil {
				ProgressView("Loading...")
			} else {
				VStack(alignment: .leading, spacing: 16) {
					content
                        .padding(.horizontal, 4)
					Spacer()
				}
				.padding(.vertical)
			}
		}
		.navigationTitle("SoBored")
		.navigationBarTitleDisplayMode(.inline)
        .alert(
            "Oops, Something went wrong!",
            isPresented: .constant(error != nil),
            actions: {
                Button("Ok", action: dismiss.callAsFunction)
            },
            message: {
                Text(error?.localizedDescription ?? "Error")
            }
        )
	}
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NavigationView {
                ActivityView(
                    activity: .example1,
                    error: nil
                )
            }

            Divider()

            NavigationView {
                ActivityView(
                    activity: .example2,
                    error: nil
                )
            }
        }
		.preferredColorScheme(.dark)
	}
}

// MARK: Main Content
fileprivate extension ActivityView {
	var content: some View {
		VStack(alignment: .leading, spacing: 16) {
			Group {
				mainSection
				detailSection
				linkSection
			}
            .padding(16)
			.background(
				Color.secondarySystemBackground,
				in: RoundedRectangle(cornerRadius: 16, style: .continuous)
			)
		}
        .padding(8)
        .background(
            Color.secondarySystemBackground.opacity(0.5),
            in: RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
	}
}

// MARK: Main Section
fileprivate extension ActivityView {
	@ViewBuilder
	var activityDescription: some View {
		Text("You should...")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		Text(activity!.activity)
			.font(.system(.subheadline, design: .rounded))
	}

	@ViewBuilder
	var activityType: some View {
		Text("Type")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		ActivityTypeLabel(type: activity!.type)
			.font(.system(.subheadline, design: .rounded))
	}

	var mainSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			activityDescription
			Divider()
			activityType
		}
	}
}

// MARK: Detail Section
fileprivate extension ActivityView {
	var participantsLabel: some View {
		Label {
			activity!.participants == 1 ? Text("Participant") : Text("Participants")
		} icon: {
			Image(systemName: "\(activity!.participants).circle.fill")
		}
	}

	var costLabel: some View {
		Label {
			Text("Cost")
		} icon: {
			CostSymbolView(cost: activity!.cost)
		}
	}

	@ViewBuilder
	var detailSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Details")
				.font(
					.system(.body, design: .rounded)
					.weight(.semibold)
				)

			HStack(spacing: 8) {
				participantsLabel
				Divider().frame(height: 15)
				costLabel
				Divider().frame(height: 15)
				AccessibilityLevelView(level: activity!.accessibilityLevel)
			}
			.font(.system(.subheadline, design: .rounded))
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

// MARK: Link Section
fileprivate extension ActivityView {
	@ViewBuilder
	var activityLink: some View {
		if let url = activity!.activityURL {
			Link(destination: url) {
				Label {
					Text(activity!.link.trimmingPrefix("https://"))
				} icon: {
					Image(systemName: "link")
				}
			}.font(.system(.subheadline, design: .rounded))
		}
	}

	@ViewBuilder
	var linkSection: some View {
		if activity!.activityURL != nil {
			VStack(alignment: .leading, spacing: 8) {
				Text("Helpful link to get you started")
					.font(
						.system(.body, design: .rounded)
						.weight(.semibold)
					)
				activityLink
			}.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}

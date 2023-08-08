//
//  HomeView.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct HomeView: View {
	@StateObject private var vm = HomeViewModel()

	var body: some View {
		NavigationView {
			ZStack {
				Color.systemBackground.ignoresSafeArea()

				VStack(spacing: 20) {
					titleText
					navLinks
				}
				.layeredBackground()
			}
			.alert(
				"Oops, Something went wrong!",
				isPresented: .getOnly(vm.activity == nil && vm.error != nil),
				actions: {},
				message: {
					Text(vm.error?.localizedDescription ?? "Error")
				}
			)
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
			.preferredColorScheme(.dark)
	}
}

// MARK: SubViews
fileprivate extension HomeView {
	var titleText: some View {
		VStack(spacing: 0) {
			Text("So Bored?")
				.font(
					.system(.largeTitle, design: .rounded)
					.weight(.bold)
				)
			Text("Take your pick")
				.font(
					.system(.title, design: .rounded)
				)
				.padding()
		}
	}

	var navLinks: some View {
		VStack(spacing: 40) {
			Button("Any Random Activity") {
				Task { await vm.fetchRandom() }
			}
			.largeGradientButton()
			.multilineTextAlignment(.center)
			.background {
				NavigationLink("",
					isActive: .getOnly(vm.error == nil && vm.activity != nil)
				) {
					ActivityView(activity:  vm.activity ?? .examples.randomElement()!)
				}.hidden()
			}

			NavigationLink("Specific Random Activity") {
				CustomActivitySearchView()
			}
			.largeGradientButton(invertedGradient: true)
			.multilineTextAlignment(.center)
		}
	}
}

// MARK: Helpers
fileprivate extension View {
	func layeredBackground() -> some View {
		self
			.padding(16)
			.background(
				Color.secondarySystemBackground,
				in: RoundedRectangle(cornerRadius: 12, style: .continuous)
			)
			.padding(8)
			.background(
				Color.secondarySystemBackground.opacity(0.5),
				in: RoundedRectangle(cornerRadius: 16, style: .continuous)
			)
	}
}

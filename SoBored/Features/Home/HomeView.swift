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
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
			.preferredColorScheme(.dark)
	}
}

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
            NavigationLink("Any Random Activity") {
                ActivityView(
                    activity: vm.activity,
                    error: vm.error
                ).task { await vm.fetchRandom() }
            }
            .largeBlueButton()

            NavigationLink("Specific Random Activity") {
                CustomActivitySearchView()
            }
            .largeBlueButton(invertedGradient: true)
        }
    }
}

fileprivate extension View {
    func layeredBackground() -> some View {
        self
            .padding(16)
            .background(
                Color.secondarySystemBackground,
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .padding(8)
            .background(
                Color.secondarySystemBackground.opacity(0.5),
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}

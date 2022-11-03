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
			VStack {
				Spacer()

				NavigationLink("Any Random Activity") {
					ActivityView(
						activity: vm.activity,
						error: $vm.error
					).task { await vm.fetchRandom() }
				}
                .largeBlueButton()
				.padding()

				NavigationLink("Specific Random Activity") {
					CustomActivitySearchView()
				}
                .largeBlueButton()
				.padding()

				Spacer()
			}
			.navigationTitle("SoBored")
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
			.preferredColorScheme(.dark)
	}
}

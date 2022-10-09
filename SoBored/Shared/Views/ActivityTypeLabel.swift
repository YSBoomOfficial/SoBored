//
//  ActivityTypeLabel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct ActivityTypeLabel: View {
	let type: ActivityItem.ActivityType

	var body: some View {
		Label {
			Text(type.title)
		} icon: {
			Image(systemName: type.symbol)
		}
	}
}

struct ActivityTypeLabel_Previews: PreviewProvider {
	static var previews: some View {
		ActivityTypeLabel(type: .education)
	}
}

//
//  CostSymbolView.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct CostSymbolView: View {
	let cost: ActivityItem.Cost
	private let symbol = Locale.current.currencySymbol ?? "$"

	var body: some View {
		HStack(spacing: 0) {
			switch cost {
                case .unspecified: Text("???").font(.caption)
				case .free:
					Text("FREE").font(.caption)
				case .low:
					Text(symbol)

					if !UIAccessibility.shouldDifferentiateWithoutColor {
						Text(symbol).opacity(0.3)
						Text(symbol).opacity(0.3)
					}
				case .medium:
					Text(symbol)
					Text(symbol)

					if !UIAccessibility.shouldDifferentiateWithoutColor {
						Text(symbol).opacity(0.3)
					}
				case .high:
					Text(symbol)
					Text(symbol)
					Text(symbol)
			}
		}
	}
}

struct CostSymbolView_Previews: PreviewProvider {
	static var previews: some View {
		VStack(spacing: 10) {
			ForEach(ActivityItem.Cost.allCases, content: CostSymbolView.init(cost:))
		}.preferredColorScheme(.dark)
	}
}

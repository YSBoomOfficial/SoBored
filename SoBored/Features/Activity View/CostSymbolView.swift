//
//  CostSymbolView.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import SwiftUI

struct CostSymbolView: View {
	let cost: ActivityItem.Cost

	var body: some View {
		HStack(spacing: 0) {
			let symbol = Locale.current.currencySymbol ?? "$"
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
		VStack {
			ForEach(ActivityItem.Cost.allCases) { cost in
				CostSymbolView(cost: cost)
			}
		}
	}
}

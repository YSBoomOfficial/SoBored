//
//  String+trimmingPrefix.swift
//  SoBored
//
//  Created by Yash Shah on 10/10/2022.
//

import Foundation

extension String {
	func trimmingPrefix(_ prefix: String) -> String {
		guard self.hasPrefix(prefix) else { return self }
		return String(dropFirst(prefix.count))
	}
}

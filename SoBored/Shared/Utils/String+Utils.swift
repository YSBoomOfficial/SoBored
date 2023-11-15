//
//  String+trimmingPrefix.swift
//  SoBored
//
//  Created by Yash Shah on 10/10/2022.
//

import Foundation

extension String {
	func trimmingPrefix(_ prefix: String) -> String {
        guard !prefix.isEmpty, hasPrefix(prefix) else { return self }
		return String(dropFirst(prefix.count))
	}
    
    func trimmingSuffix(_ suffix: String) -> String {
        guard !suffix.isEmpty, hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
}

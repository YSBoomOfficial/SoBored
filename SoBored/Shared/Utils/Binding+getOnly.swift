//
//  Binding+getOnly.swift
//  SoBored
//
//  Created by Yash Shah on 08/08/2023.
//

import Foundation
import SwiftUI

extension Binding {
	/// use in place of ``Binding.constant`` as it does not re trigger SwiftUI Alert
	static func getOnly(_ value: Value) -> Binding<Value> {
		.init(get: { value }, set: { _ in })
	}
}

//
//  MainService.swift
//  My-Stocks
//
//  Created by Mostafa AlBelliehy on 10/04/2020.
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation

class MainService: BaseService {
	public static let shared = MainService();
	
	private init() {
		// Pass different JSONDecoder to super.init() when needed
		super.init();
	}
	
	// MARK: - Service Calls
}

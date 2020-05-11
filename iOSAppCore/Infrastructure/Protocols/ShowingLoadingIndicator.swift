//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation

protocol ShowingLoadingIndicator {
	// The loading indicator
	var spinnerVC: SpinnerVC! { get set };
	
	// Shows the spinner
	func showIndicator();
	
	// Hides the spinner
	func hideIndicator();
}

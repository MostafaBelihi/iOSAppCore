//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

class Common {
	static func alert(msg: String,view: UIViewController){
		let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert);
		alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil));
		view.present(alert, animated: true);
	}
	
	static func confirmationAlert(_ vc: UIViewController, _ msg: String, handler: @escaping (UIAlertAction)->()){
		let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert);
		alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: handler));
		alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .default, handler: nil));
		vc.present(alert, animated: true);
	}
	
	static func errorAlert(_ vc: UIViewController, _ msg: String, handler: @escaping (UIAlertAction)->()){
		let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert);
		alert.addAction(UIAlertAction(title: NSLocalizedString("retry", comment: ""), style: .default, handler: handler));
		alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil));
		vc.present(alert, animated: true);
	}
	
	static func debugLog(isInit: Bool = false, title: String = "Debug Log", _ items: Any...) {
		if (isInit) {
			print(".");
			print(".");
			print(".");
			print(".");
			print(".");
			print(".");
			print(".......................................................");
		}

		print("\(title):");
		debugPrint(items);
		print(".......................................................");
	}
}

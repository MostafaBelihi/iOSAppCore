//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

class AppManager {
	init() {
		
	}
	
	/// Setup app window
	func setupAppWindow() {
		// NavBar style
		UINavigationBar.appearance().isTranslucent = false;
		UINavigationBar.appearance().tintColor = AppColor.tintPrimary;
		UINavigationBar.appearance().barTintColor = AppColor.viewBackgroundSecondary;
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.textPrimary, NSAttributedString.Key.font: AppFont.semiBold(.big).font];
		
		// Get app main objects
		let storyboard = UIStoryboard(name: "Main", bundle: nil);
		let appDelegate = UIApplication.shared.delegate as! AppDelegate;
		appDelegate.window?.rootViewController = nil;
		
		// Setup NavigationController and MainVC
		let mainVCIdentifier = "MainVC";
		let mainViewController = storyboard.instantiateViewController(withIdentifier: mainVCIdentifier);
		let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController);
		
		// Setup app window
		appDelegate.window?.rootViewController = nvc;
		appDelegate.window?.resignKey();
		appDelegate.window?.makeKeyAndVisible();
	}
	
	/// Shows a UIAlertController with languages to choose from.
	/// - Parameter vc: The VC that calls this mehod, to present the UIAlertController.
	func languageSwitcher(vc: UIViewController){
		// Language Switcher
		let actionSheetController = UIAlertController(title: NSLocalizedString("chooseLang", comment: ""), message: "", preferredStyle: .alert);
		
		// Loop through languages
		for lang in Language.allCases {
			let langActionButton = UIAlertAction(title: lang.name, style: .default) { action -> Void in
				if(LocaleManager.languageCode! != lang.code) {
					Bundle.set(language: lang);
					self.setupAppWindow();
				}
			}
			
			actionSheetController.addAction(langActionButton);
		}
		
		let cancelActionButton = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil);
		actionSheetController.addAction(cancelActionButton);
		
		//		actionSheetController.view.tintColor = colorPrimary;
		vc.present(actionSheetController, animated: false, completion: nil)
	}
}

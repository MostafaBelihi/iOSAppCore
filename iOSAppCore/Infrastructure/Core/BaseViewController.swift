//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: StyleUIViewControllerBase, ShowingLoadingIndicator, DismissingKeyboard, Scrollable, CheckingConnectionStatus, ShowingError {
	
	// MARK: - VC Events
	override func viewDidLoad() {
        super.viewDidLoad()

		// Tap Gesture
		setupTapGesture();
		
		// Connectivity
		checkConnection();

    }

	// MARK: - Spinner/Indicator
	var spinnerVC: SpinnerVC!
	
	func showIndicator() {
		spinnerVC = SpinnerVC();
		addChildVC(spinnerVC);
	}
	
	func hideIndicator() {
		spinnerVC.removeFromParentVC();
	}
	
	// MARK: - Error View
	func showError(errorMessage: String, actionButtonText: String, action: @escaping ()->()) {
		let vc = ErrorVC(nibName: "ErrorVC", bundle: nil);
		
		// Params for ErrorVC
		vc.errorMessage = errorMessage;
		vc.actionButtonText = actionButtonText;
		vc.action = action;
		
		// Detach view and show it
		let errorView = vc.view;
		errorView?.fixInView(view);
		addChildVC(vc);
	}
	
	// MARK: - Gesture: Dismiss Keyboard
	internal func setupTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapHandler(recognizer:)));
		tapGesture.cancelsTouchesInView = false;
		self.view.addGestureRecognizer(tapGesture);
	}
	
	@objc internal func viewTapHandler(recognizer: UISwipeGestureRecognizer) {
		self.view.endEditing(true);
	}

	// MARK: - Check Connection Status
	internal func checkConnection() {
		NetworkManager.isUnreachable { (networkManager) in
			Common.alert(msg: NSLocalizedString("networkError", comment: ""), view: self);
		}
	}
	
	// MARK: - Scrolling
	
	/*
	Refer to this link for details: https://www.evernote.com/shard/s19/nl/2294787/66ff962b-12d4-4dad-911b-466b8bf5a22e/
	Brief steps:
	- Set top view's size to Freeform
	- Add a content view (ViewContent) with no siblings, use appropriate contraints for it
	- Follow the mentioned link about its size and position
	- Reference the ViewContent in your code
	- Call the setupScrollView method, and pass the ViewContent to it
	*/
	
	var scrollView = UIScrollView();
	var viewScrolledContent = UIView();

	// Call this method only if you have scrolling in your ViewConroller, take care of the Prerequisites above
	func setupScrollView(contentView: UIView){
		// Detach the content view from super view
		contentView.removeFromSuperview();
		
		/// Build control hierarchy for scrolling
		// ScrollView
		scrollView.translatesAutoresizingMaskIntoConstraints = false;
		view.addSubview(scrollView);
		scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true;
		scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true;
		scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
		scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
		
		// ViewScrolledContent
		viewScrolledContent.translatesAutoresizingMaskIntoConstraints = false;
		scrollView.addSubview(viewScrolledContent);
		viewScrolledContent.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
		viewScrolledContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
		viewScrolledContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
		viewScrolledContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
		viewScrolledContent.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
		
		// Content View
		contentView.translatesAutoresizingMaskIntoConstraints = false;
		viewScrolledContent.addSubview(contentView);
		contentView.topAnchor.constraint(equalTo: viewScrolledContent.topAnchor).isActive = true;
		contentView.bottomAnchor.constraint(equalTo: viewScrolledContent.bottomAnchor).isActive = true;
		contentView.leadingAnchor.constraint(equalTo: viewScrolledContent.leadingAnchor).isActive = true;
		contentView.trailingAnchor.constraint(equalTo: viewScrolledContent.trailingAnchor).isActive = true;
	}
	
}

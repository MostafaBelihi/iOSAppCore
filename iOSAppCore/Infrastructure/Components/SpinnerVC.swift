//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

class SpinnerVC: UIViewController {
	private lazy var indicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.color = .white;
        view.addSubview(indicator)
		

        // Constraints
		NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			self?.view.backgroundColor = AppColor.getColor(fromHex: "434343");
			self?.view.layer.opacity = 0.34;
            
			self?.indicator.startAnimating()
        }
    }
}

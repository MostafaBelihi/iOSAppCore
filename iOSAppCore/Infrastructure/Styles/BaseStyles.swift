//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

class StyleUIViewControllerBase: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = AppColor.viewBackgroundPrimary;
	}
}

class StyleUIViewBase: UIView {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = AppColor.viewBackgroundPrimary;
	}
}

class StyleUILabelBase: UILabel {
	override func awakeFromNib() {
		super.awakeFromNib()

		font = AppFont.regular(.normal).font;
		textColor = AppColor.textPrimary;
	}
}

class StyleUIButtonBase: UIButton {
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
}

class StyleUIImageViewBase: UIImageView {
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
}

class StyleUITextFieldBase: UITextField {
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
}

//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

/// Common styling constants and methods

// MARK: - Colors
class AppColor {
	/// Config colors
	// Background
	static let viewBackgroundPrimary: UIColor = .white;
	static let viewBackgroundSecondary: UIColor = .gray;
	
	// Text
	static let textPrimary: UIColor = .black;
	static let textSecondary: UIColor = .black;
	static let textSecondary2: UIColor = .black;
	
	// Tint
	static let tintPrimary: UIColor = .white;
	static let tintSecondary: UIColor = .gray;

	/// Resolve color code
	/// - Parameter hex: Color Hex value.
	static func getColor(fromHex hex:String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}
		
		if ((cString.count) != 6) {
			return UIColor.gray
		}
		
		var rgbValue:UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}

// MARK: - Fonts
enum AppFont {
	// Font Weights
	case light(FontSize)
	case regular(FontSize)
	case medium(FontSize)
	case semiBold(FontSize)
	case bold(FontSize)
	case extraBold(FontSize)
	
	// Config Font Sizes
	enum FontSize {
		case tiny
		case small
		case normal
		case medium
		case big
		case large
		
		var value: CGFloat {
			switch self {
				case .tiny: return UIDevice.current.userInterfaceIdiom == .pad ? 15 : 10;
				case .small: return UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15;
				case .normal:  return UIDevice.current.userInterfaceIdiom == .pad ? 23 : 18;
				case .medium:  return UIDevice.current.userInterfaceIdiom == .pad ? 25 : 20;
				case .big: return UIDevice.current.userInterfaceIdiom == .pad ? 30 : 25;
				case .large: return UIDevice.current.userInterfaceIdiom == .pad ? 35 : 30;
			}
		}
	}
	
	// Config Font Names
	func fontName(for language: Language) -> String {
		switch language {
			case .english:
				switch self {
					case .light: return "Quicksand-Light";
					case .regular: return "Quicksand-Regular";
					case .medium: return "Quicksand-Medium";
					case .semiBold: return "Quicksand-SemiBold";
					case .bold: return "Quicksand-Bold";
					case .extraBold: return "";
			}
		}
	}

	// Gets the raw value of fontSize
	var fontSize: CGFloat {
		switch self {
			case .light(let fontSize),
				 .regular(let fontSize),
				 .medium(let fontSize),
				 .semiBold(let fontSize),
				 .bold(let fontSize),
				 .extraBold(let fontSize):
				return fontSize.value;
		}
	}

	// Gets the UIFont of the set font attributes
	var font: UIFont {
		var language: Language? = LocaleManager.language;
		
		if (language == nil) {
			language = .english;
		}
		
		return UIFont(name: fontName(for: language!), size: fontSize)!;
	}
}

//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Appearance
extension UIView {
	func setupShadows(color: CGColor) {
		layer.shadowColor = color;
		layer.shadowOffset = CGSize.zero;
		layer.shadowOpacity = 1;
		layer.shadowRadius = 1;
		layer.shouldRasterize = true;
		layer.rasterizationScale = UIScreen.main.scale;
	}
	
	func rounded(radius: CGFloat) {
		layer.cornerRadius = radius;
	}

	func roundedTop(radius: CGFloat) {
		self.clipsToBounds = true
		self.layer.cornerRadius = radius
		if #available(iOS 11.0, *) {
			//            layerMaxXMaxYCorner – lower right corner
			//            layerMaxXMinYCorner – top right corner
			//            layerMinXMaxYCorner – lower left corner
			//            layerMinXMinYCorner – top left corner
			self.layer.maskedCorners =  [.layerMaxXMinYCorner, .layerMinXMinYCorner];
		} else {
			let rectShape = CAShapeLayer()
			rectShape.bounds = self.frame
			rectShape.position = self.center
			rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
			
			self.layer.mask = rectShape
		}
	}

	func roundedBottom(radius: CGFloat) {
		self.clipsToBounds = true
		self.layer.cornerRadius = radius
		if #available(iOS 11.0, *) {
			//            layerMaxXMaxYCorner – lower right corner
			//            layerMaxXMinYCorner – top right corner
			//            layerMinXMaxYCorner – lower left corner
			//            layerMinXMinYCorner – top left corner
			self.layer.maskedCorners =  [.layerMaxXMaxYCorner, .layerMinXMaxYCorner];
		} else {
			let rectShape = CAShapeLayer()
			rectShape.bounds = self.frame
			rectShape.position = self.center
			rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
			
			self.layer.mask = rectShape
		}
	}
	
	func roundedLeft(radius: CGFloat) {
		self.clipsToBounds = true
		self.layer.cornerRadius = radius
		if #available(iOS 11.0, *) {
			//            layerMaxXMaxYCorner – lower right corner
			//            layerMaxXMinYCorner – top right corner
			//            layerMinXMaxYCorner – lower left corner
			//            layerMinXMinYCorner – top left corner
			self.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMinXMaxYCorner];
		} else {
			let rectShape = CAShapeLayer()
			rectShape.bounds = self.frame
			rectShape.position = self.center
			rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .bottomLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
			
			self.layer.mask = rectShape
		}
	}

	func roundedRight(radius: CGFloat) {
		self.clipsToBounds = true
		self.layer.cornerRadius = radius
		if #available(iOS 11.0, *) {
			//            layerMaxXMaxYCorner – lower right corner
			//            layerMaxXMinYCorner – top right corner
			//            layerMinXMaxYCorner – lower left corner
			//            layerMinXMinYCorner – top left corner
			self.layer.maskedCorners =  [.layerMaxXMinYCorner, .layerMaxXMaxYCorner];
		} else {
			let rectShape = CAShapeLayer()
			rectShape.bounds = self.frame
			rectShape.position = self.center
			rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight , .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
			
			self.layer.mask = rectShape
		}
	}

	// Custom Borders
	func addBorders(edges: UIRectEdge = .all, color: UIColor = .black, width: CGFloat = 1.0) {
		
		func createBorder() -> UIView {
			let borderView = UIView(frame: CGRect.zero)
			borderView.translatesAutoresizingMaskIntoConstraints = false
			borderView.backgroundColor = color
			return borderView
		}
		
		if (edges.contains(.all) || edges.contains(.top)) {
			let topBorder = createBorder()
			self.addSubview(topBorder)
			NSLayoutConstraint.activate([
				topBorder.topAnchor.constraint(equalTo: self.topAnchor),
				topBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
				topBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
				topBorder.heightAnchor.constraint(equalToConstant: width)
				])
		}
		if (edges.contains(.all) || edges.contains(.left)) {
			let leftBorder = createBorder()
			self.addSubview(leftBorder)
			NSLayoutConstraint.activate([
				leftBorder.topAnchor.constraint(equalTo: self.topAnchor),
				leftBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
				leftBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
				leftBorder.widthAnchor.constraint(equalToConstant: width)
				])
		}
		if (edges.contains(.all) || edges.contains(.right)) {
			let rightBorder = createBorder()
			self.addSubview(rightBorder)
			NSLayoutConstraint.activate([
				rightBorder.topAnchor.constraint(equalTo: self.topAnchor),
				rightBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
				rightBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
				rightBorder.widthAnchor.constraint(equalToConstant: width)
				])
		}
		if (edges.contains(.all) || edges.contains(.bottom)) {
			let bottomBorder = createBorder()
			self.addSubview(bottomBorder)
			NSLayoutConstraint.activate([
				bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
				bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
				bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
				bottomBorder.heightAnchor.constraint(equalToConstant: width)
				])
		}
	}
	
	func addBordersWithMargin(edges: UIRectEdge = .all, color: UIColor = .black, thickness: CGFloat = 1.0, margin: CGFloat = 0.0) {
		
		func createBorder() -> UIView {
			let borderView = UIView(frame: CGRect.zero)
			borderView.translatesAutoresizingMaskIntoConstraints = false
			borderView.backgroundColor = color
			return borderView
		}
		
		if (edges.contains(.all) || edges.contains(.top)) {
			let topBorder = createBorder()
			self.addSubview(topBorder)
			NSLayoutConstraint.activate([
				topBorder.topAnchor.constraint(equalTo: self.topAnchor),
				topBorder.centerXAnchor.constraint(equalTo: self.centerXAnchor),
				topBorder.heightAnchor.constraint(equalToConstant: thickness),
				topBorder.widthAnchor.constraint(equalToConstant: self.bounds.size.width - (margin * 2))
				])
		}
		if (edges.contains(.all) || edges.contains(.left)) {
			let leftBorder = createBorder()
			self.addSubview(leftBorder)
			NSLayoutConstraint.activate([
				leftBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
				leftBorder.centerYAnchor.constraint(equalTo: self.centerYAnchor),
				leftBorder.widthAnchor.constraint(equalToConstant: thickness),
				leftBorder.heightAnchor.constraint(equalToConstant: self.bounds.size.height - (margin * 2))
				])
		}
		if (edges.contains(.all) || edges.contains(.right)) {
			let rightBorder = createBorder()
			self.addSubview(rightBorder)
			NSLayoutConstraint.activate([
				rightBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
				rightBorder.centerYAnchor.constraint(equalTo: self.centerYAnchor),
				rightBorder.widthAnchor.constraint(equalToConstant: thickness),
				rightBorder.heightAnchor.constraint(equalToConstant: self.bounds.size.height - (margin * 2))
				])
		}
		if (edges.contains(.all) || edges.contains(.bottom)) {
			let bottomBorder = createBorder()
			self.addSubview(bottomBorder)
			NSLayoutConstraint.activate([
				bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
				bottomBorder.centerXAnchor.constraint(equalTo: self.centerXAnchor),
				bottomBorder.heightAnchor.constraint(equalToConstant: thickness),
				bottomBorder.widthAnchor.constraint(equalToConstant: self.bounds.size.width - (margin * 2))
				])
		}
	}

}

// MARK: - Positioning
extension UIView
{
	func fixInView(_ container: UIView!) -> Void{
		self.translatesAutoresizingMaskIntoConstraints = false;
		self.frame = container.frame;
		container.addSubview(self);
		NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
	}
}

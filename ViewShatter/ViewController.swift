//
//  ViewController.swift
//  ViewShatter
//
//  Created by Dylan Elliott on 28/1/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

//: A UIKit based Playground for presenting user interface

import UIKit

extension UIView {
	func recurse(_ block: (UIView) -> ()) {
		for subview in self.subviews {
			subview.recurse(block)
			block(subview)
		}
	}
	
	func addPhysics(in animator: UIDynamicAnimator) {
		print("adding physics")
		let gravity = UIGravityBehavior()
		
		gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
		
		self.recurse { subview in
			let collider = UICollisionBehavior()
			collider.translatesReferenceBoundsIntoBoundary = true
			collider.addItem(subview)
			animator.addBehavior(collider)
			
			gravity.addItem(subview)
			
			if let label = subview as? UILabel {
				label.textColor = .blue
				label.text = "Hello Kevin and Syed"
			}
		}
		
		animator.addBehavior(gravity);
	}
}

class MyViewController : UITableViewController {
	
	var animator:UIDynamicAnimator!
	
	override func loadView() {
		super.loadView()
		animator = UIDynamicAnimator(referenceView:view);
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
		cell.textLabel?.text = "Hello"
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		view.addPhysics(in: animator)
		
		if let navigationController = self.navigationController as? RestorableNavigationController {
			navigationController.addTapRestoreGesture(to: self.view)
		}
	}
}

class RestorableNavigationController: UINavigationController {
	var factoryBlock: (() -> UIViewController)!
	
	init(factoryBlock: @escaping () -> UIViewController) {
		self.factoryBlock = factoryBlock
		super.init(nibName: nil, bundle: nil)
		restore()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		fatalError("init(nibName: bundle:) has not been implemented")
	}
	
	@objc func restore() {
		print("restoring")
		self.viewControllers = [factoryBlock()]
	}
	
	func addTapRestoreGesture(to view: UIView) {
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restore)))
	}
}


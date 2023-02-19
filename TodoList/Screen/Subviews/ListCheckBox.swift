//
//  ListCheckBox.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

/// Delegate for handling actions related to ListCheckBox
protocol ListCheckBoxDelegate: AnyObject {
	
	/// Delegate method that registers the change when the element is clicked
	/// - Parameter select: Current value
	func update(select: Bool)
}

/// Class describing the implementation of the CheckBox in the user interface
final class ListCheckBox: UIControl {

	private var imageView: UIImageView!
	
	/// Property delegate
	weak var delegate: ListCheckBoxDelegate?
	
	override var isSelected: Bool {
		didSet {
			imageView.image = chekedImage()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension ListCheckBox {
	
	func configureView() {
		addTarget(self, action: #selector(selected), for: .touchUpInside)
		configureCheckBoxImageView()
	}
	
	func configureCheckBoxImageView() {
		imageView = UIImageView(image: chekedImage())
		imageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(imageView)
		imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	func chekedImage() -> UIImage? {
		isSelected ? UIImage(named: "checked") : UIImage(named: "unchecked")
	}
}

@objc private extension ListCheckBox {
	
	func selected() {
		isSelected.toggle()
		delegate?.update(select: isSelected)
	}
}

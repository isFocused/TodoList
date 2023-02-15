//
//  ListRelurTaskCell.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
	
	func updateAction()
}

final class ListRelurTaskCell: UITableViewCell {

	private var checkBox: ListCheckBox!
	private var titleLabel: UILabel!
	
	private var model: RegularTask?
	
	weak var delegate: TaskCellDelegate?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ListRelurTaskCell {
	
	/// Set model for cell
	func setModel(_ model: RegularTask?) {
		self.model = model
		checkBox.isSelected = model?.isComplited ?? false
		titleLabel.text = model?.title
	}
}

extension ListRelurTaskCell: ListCheckBoxDelegate {
	
	func update(select: Bool) {
		model?.isComplited = select
		delegate?.updateAction()
	}
}

fileprivate extension ListRelurTaskCell {
	
	func configureCell() {
		selectionStyle = .none
		createCheckBox()
		createTitleLabel()
	}
	
	func createCheckBox() {
		checkBox = ListCheckBox(frame: .zero)
		checkBox.delegate = self
		checkBox.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(checkBox)
		checkBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		checkBox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		checkBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
		checkBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
	}
	
	func createTitleLabel() {
		titleLabel = UILabel()
		titleLabel.numberOfLines = .zero
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 16).isActive = true
		titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
	}
}

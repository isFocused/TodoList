//
//  ListImportantTaskCell.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

final class ListImportantTaskCell: UITableViewCell {

	private var checkBox: ListCheckBox!
	private var titleLabel: UILabel!
	private var deadlineLabel: UILabel!
	private var idicatorImageView: UIImageView!
	
	private var model: ImportantTask?
	
	weak var delegate: TaskCellDelegate?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ListImportantTaskCell {
	
	/// Set model for cell
	func setModel(_ model: ImportantTask?) {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.y"
		guard let model = model else { return }
		contentView.backgroundColor = model.deadlineDate < Date() ? .systemPink : .white
		checkBox.isSelected = model.isComplited
		titleLabel.text = model.title
		idicatorImageView.image = configureImage(priority: model.priority)
		deadlineLabel.text = formatter.string(from: model.deadlineDate)
		self.model = model
	}
}

extension ListImportantTaskCell: ListCheckBoxDelegate {
	
	func update(select: Bool) {
		model?.isComplited = select
		delegate?.updateAction()
	}
}

private extension ListImportantTaskCell {
	
	func configureCell() {

		selectionStyle = .none
		createCheckBox()
		createTitleLabel()
		createIdicatorImageView()
		createDeadlineLabel()
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
		titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
	}
	
	func createIdicatorImageView() {
		idicatorImageView = UIImageView()
		idicatorImageView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(idicatorImageView)
		idicatorImageView.topAnchor.constraint(greaterThanOrEqualTo: checkBox.bottomAnchor, constant: 10).isActive = true
		idicatorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		idicatorImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
		idicatorImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
		idicatorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
	}
	
	func createDeadlineLabel() {
		deadlineLabel = UILabel()
		deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(deadlineLabel)
		deadlineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
		deadlineLabel.leadingAnchor.constraint(equalTo: idicatorImageView.trailingAnchor, constant: 16).isActive = true
		deadlineLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
		deadlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
	}
	
	func configureImage(priority: Priority) -> UIImage? {
		switch priority {
		case .low:
			return UIImage(named: "low-priority")
		case .normal:
			return UIImage(named: "medium-priority")
		case .height:
			return UIImage(named: "high-priority")
		}
	}
}

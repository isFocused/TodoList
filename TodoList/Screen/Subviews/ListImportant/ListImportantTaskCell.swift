//
//  ListImportantTaskCell.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

/// A class that describes a cell that displays an important task
final class ListImportantTaskCell: UITableViewCell {

	static let identifier = String(describing: type(of: ListImportantTaskCell.self))
	
	private var checkBox: ListCheckBox!
	private var titleLabel: UILabel!
	private var deadlineLabel: UILabel!
	private var idicatorImageView: UIImageView!
	
	private var presenterCell: ListImportantPresenterCell?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Method that sets the presenter for the current cell
	/// - Parameter presenter: Created Presenter
	func setPresenter(_ presenter: IListRegularPresentorCell) {
		presenterCell = presenter as? ListImportantPresenterCell
		presenterCell?.view = self
		presenterCell?.configure()
	}
}

extension ListImportantTaskCell: ListCellView {
	
	func render(viewData: ListCellViewData) {
		if case let .important(content) = viewData {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd.MM.y"
			contentView.backgroundColor = content.deadlineDate < Date() ? .systemPink : .white
			checkBox.isSelected = content.isComplited
			titleLabel.text = content.title
			idicatorImageView.image = configureImage(priority: content.priority)
			deadlineLabel.text = formatter.string(from: content.deadlineDate)
		}
	}
}

extension ListImportantTaskCell: ListCheckBoxDelegate {
	
	func update(select: Bool) {
		presenterCell?.updateStateComplited(value: select)
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

//
//  ListRegularTaskCell.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

/// Model for transferring and creating a child grantor
enum ListCellViewData {
	
	case regular(RegularTask)
	case important(ImportantTask)
}

/// Protocol describing the functionality of the interaction between the view and the presenter of the cell
protocol ListCellView: AnyObject {
	
	/// Display data configuration method
	/// - Parameter viewData: Passed model value
	func render(viewData: ListCellViewData)
}

/// Class describing a cell displaying a regular task
final class ListRegularTaskCell: UITableViewCell {

	static let identifier = String(describing: type(of: ListRegularTaskCell.self))
	
	private var checkBox: ListCheckBox!
	private var titleLabel: UILabel!
	
	private var presenterCell: ListRegularPresentorCell?
	
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
		presenterCell = presenter as? ListRegularPresentorCell
		presenterCell?.view = self
		presenterCell?.configure()
	}
}

extension ListRegularTaskCell: ListCellView {
	
	func render(viewData: ListCellViewData) {
		if case let .regular(content) = viewData {
			checkBox.isSelected = content.isComplited
			titleLabel.text = content.title
		}
	}
}

extension ListRegularTaskCell: ListCheckBoxDelegate {
	
	func update(select: Bool) {
		presenterCell?.updateStateComplited(value: select)
	}
}

fileprivate extension ListRegularTaskCell {
	
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

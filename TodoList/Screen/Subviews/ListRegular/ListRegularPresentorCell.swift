//
//  ListRegularPresentorCell.swift
//  TodoList
//
//  Created by Denis Ivanov on 19.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

/// Protocol describing the functionality of a cell presenter
protocol IListRegularPresentorCell: AnyObject {
	
	/// Properties to communicate with the custom element
	var view: ListCellView? { get set }
	
	/// Task execution value update method
	/// - Parameter value: The value to which the current
	func updateStateComplited(value: Bool)
	/// Method initiating data configuration
	func configure()
}

/// Child presenter class for a cell
final class ListRegularPresentorCell: IListRegularPresentorCell {
	
	private unowned let parentPresenter: IListPresenter
	private let model: RegularTask
	
	/// Properties to communicate with the custom element
	weak var view: ListCellView?
	
	/// An initializer that creates a presenter
	/// - Parameters:
	///   - parentPresenter: Parent presenter, to link the child structure
	///   - model: Model describing the data of the current task
	init(parentPresenter: IListPresenter, model: RegularTask) {
		self.parentPresenter = parentPresenter
		self.model = model
	}
	
	/// Task execution value update method
	/// - Parameter value: The value to which the current
	func updateStateComplited(value: Bool) {
		model.isComplited = value
		parentPresenter.reloadTasks()
	}
	
	/// Method initiating data configuration
	func configure() {
		view?.render(viewData: .regular(model))
	}
}

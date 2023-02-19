//
//  ListPresenter.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

/// <#Description#>
protocol IListPresenter: AnyObject {
	
	/// <#Description#>
	/// - Parameter indexPath: <#indexPath description#>
	/// - Returns: <#description#>
	func cellForRowAt(indexPath: IndexPath) -> IListRegularPresentorCell
	/// <#Description#>
	/// - Parameter section: <#section description#>
	/// - Returns: <#description#>
	func numberOfRowsInSection(section: Int) -> Int
	/// <#Description#>
	/// - Returns: <#description#>
	func numberOfSections() -> Int
	/// <#Description#>
	/// - Parameter section: <#section description#>
	/// - Returns: <#description#>
	func titleForHeaderInSection(section: Int) -> String
	/// <#Description#>
	func fetchTasks()
	/// <#Description#>
	func reloadTasks()
}

/// <#Description#>
final class ListPresenter: IListPresenter {
	
	private let sectionManager: SectionForTaskManagerAdapter
	private var tasks: [ListSectionPresenter]
	private weak var view: IListView?
	
	/// <#Description#>
	/// - Parameters:
	///   - view: <#view description#>
	///   - sectionManager: <#sectionManager description#>
	init(view: IListView, sectionManager: SectionForTaskManagerAdapter) {
		self.view = view
		self.sectionManager = sectionManager
		tasks = []
	}
	
	/// <#Description#>
	/// - Parameter section: <#section description#>
	/// - Returns: <#description#>
	func numberOfRowsInSection(section: Int) -> Int {
		switch tasks[section] {
		case .completed(let tasks), .uncompleted(let tasks):
			return tasks.count
		}
	}
	
	/// <#Description#>
	/// - Parameter indexPath: <#indexPath description#>
	/// - Returns: <#description#>
	func cellForRowAt(indexPath: IndexPath) -> IListRegularPresentorCell {
		switch tasks[indexPath.section] {
		case .completed(let tasks), .uncompleted(let tasks):
			return tasks[indexPath.row]
		}
	}
	
	/// <#Description#>
	func fetchTasks() {
		tasks = sectionManager.configureSection(presenter: self)
	}
	
	/// <#Description#>
	func reloadTasks() {
		fetchTasks()
		view?.reloadData()
	}
	
	/// <#Description#>
	/// - Returns: <#description#>
	func numberOfSections() -> Int {
		tasks.count
	}
	
	/// <#Description#>
	/// - Parameter section: <#section description#>
	/// - Returns: <#description#>
	func titleForHeaderInSection(section: Int) -> String {
		tasks[section].title
	}
}

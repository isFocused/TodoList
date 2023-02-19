//
//  SectionTaskManagerAdapter.swift
//  TodoList
//
//  Created by Denis Ivanov on 19.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

/// The class creates sections for later display
final class SectionForTaskManagerAdapter {
	
	private let taskManager: ITaskManager
	
	/// An initializer that creates a class that configures a session
	/// - Parameter taskManager: Object of type ITaskManager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// The method creates sections for later use by the controller's presenter
	/// - Parameter presenter: The parent presenter with which the cell presenters will be configured
	/// - Returns: Child item presenters
	func configureSection(presenter: IListPresenter) -> [ListSectionPresenter] {
		[
			.completed(taskManager.getTasksCompleted().map { createItem(from: $0, presenter) }),
			.uncompleted(taskManager.getTasksUnCompleted().map { createItem(from: $0, presenter) })
		]
	}
	
	private func createItem(from task: RegularTask, _ presenter: IListPresenter) -> IListRegularPresentorCell {
		guard let importantTask = task as? ImportantTask else {
			return ListRegularPresentorCell(parentPresenter: presenter, model: task)
		}
		return ListImportantPresenterCell(parentPresenter: presenter, model: importantTask)
	}
}

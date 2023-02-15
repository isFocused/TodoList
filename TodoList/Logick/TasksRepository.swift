//
//  TasksRepository.swift
//  TodoList
//
//  Created by Denis Ivanov on 15.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

protocol IRepository: AnyObject {
	
	func createStub()
	func getSection() -> [Section]
}

final class TasksRepository: IRepository {
	
	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// Creates mock objects for testing
	func createStub() {
		taskManager.add(RegularTask(title: "Task"))
		taskManager.add(RegularTask(title: "Task 1"))
		taskManager.add(RegularTask(isCompleted: true, title: "Regular task"))
		taskManager.add(ImportantTask(priorety: .height, title: "Important task"))
		taskManager.add(ImportantTask(priorety: .normal, title: "Important task"))
		taskManager.add(ImportantTask(priorety: .low, title: "Important task"))
		taskManager.add(ImportantTask(priorety: .low, isCompleted: true, title: "Important task"))
	}
	
	/// Requests all tasks
	/// - Returns: All tasks
	func getSection() -> [Section] {
		[.completed(filterCompleted()), .uncompleted(filterUnCompleted())]
	}
	
	private func filterUnCompleted() -> [RegularTask] {
		let regularTasks = taskManager.getTasksUnCompleted().filter { !($0 is ImportantTask) }
		let importantTasks = taskManager.getTasksUnCompleted()
			.compactMap { $0 as? ImportantTask }
			.sorted { $0.priority > $1.priority }
		return importantTasks + regularTasks
	}
	
	private func filterCompleted() -> [RegularTask] {
		let regularTasks = taskManager.getTasksCompleted().filter { !($0 is ImportantTask) }
		let importantTasks = taskManager.getTasksCompleted()
			.compactMap { $0 as? ImportantTask }
			.sorted { $0.priority > $1.priority }
		return importantTasks + regularTasks
	}
}

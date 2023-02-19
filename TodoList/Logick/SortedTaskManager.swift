//
//  SortedTaskManager.swift
//  TodoList
//
//  Created by Denis Ivanov on 19.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

///  Class sorting tasks for subsequent display
final class SortedTaskManager: ITaskManager {
	
	private let taskManager: ITaskManager
	
	/// The initializer accepts an ITaskManager protocol object
	/// - Parameter taskManager: Object of type ITaskManager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// Method returning all tasks
	/// - Returns: Task array
	func getAllTasks() -> [RegularTask] {
		sorted(tasks: taskManager.getAllTasks())
	}
	
	/// Requests a sorted array of completed tasks
	/// - Returns: Task array
	func getTasksCompleted() -> [RegularTask] {
		sorted(tasks: taskManager.getTasksCompleted())
	}
	
	/// Requests a sorted array of uncompleted tasks
	/// - Returns: Task array
	func getTasksUnCompleted() -> [RegularTask] {
		sorted(tasks: taskManager.getTasksUnCompleted())
	}
	
	/// Adds a new task
	/// - Parameter task: Task
	func add(_ task: RegularTask) {
		taskManager.add(task)
	}
	
	/// Deletes a task
	/// - Parameter task: Task
	func remove(_ task: RegularTask) {
		taskManager.remove(task)
	}
	
	private func sorted(tasks: [RegularTask]) -> [RegularTask] {
		tasks.sorted {
			if let firstTask = $0 as? ImportantTask, let secondTask = $1 as? ImportantTask {
				return firstTask.priority > secondTask.priority
			}
			return $0 is ImportantTask
		}
	}
}

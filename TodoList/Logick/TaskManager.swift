//
//  TaskManager.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

protocol ITaskManager: AnyObject {
	
	func getAllTasks() -> [RegularTask]
	func getTasksCompleted() -> [RegularTask]
	func getTasksUnCompleted() -> [RegularTask]
	func add(_ task: RegularTask)
	func remove(_ task: RegularTask)
}

final class TaskManager: ITaskManager {
	
	private var tasks: [RegularTask]
	
	init() {
		tasks = []
	}
	
	/// Requests an array of all tasks
	/// - Returns: Task array
	func getAllTasks() -> [RegularTask] {
		tasks
	}

	/// Requests a sorted array of completed tasks
	/// - Returns: Task array
	func getTasksCompleted() -> [RegularTask] {
		getAllTasks().filter { $0.isComplited }
	}

	/// Requests a sorted array of uncompleted tasks
	/// - Returns: Task array
	func getTasksUnCompleted() -> [RegularTask] {
		getAllTasks().filter { !$0.isComplited }
	}
	
	/// Adds a new task
	/// - Parameter task: Task
	func add(_ task: RegularTask) {
		tasks.append(task)
	}
	
	/// Deletes a task
	/// - Parameter task: Task
	func remove(_ task: RegularTask) {
		tasks = tasks.filter { $0.id != task.id }
	}
}

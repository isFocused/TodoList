//
//  TaskManager.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

/// Protocol declaring a task storage manager
protocol ITaskManager: AnyObject {
	
	/// Method returning all tasks
	/// - Returns: Task array
	func getAllTasks() -> [RegularTask]
	
	/// Requests a sorted array of completed tasks
	/// - Returns: Task array
	func getTasksCompleted() -> [RegularTask]
	
	/// Requests a sorted array of uncompleted tasks
	/// - Returns: Task array
	func getTasksUnCompleted() -> [RegularTask]
	
	/// Adds a new task
	/// - Parameter task: Task
	func add(_ task: RegularTask)
	
	/// Deletes a task
	/// - Parameter task: Task
	func remove(_ task: RegularTask)
}

final class TaskManager: ITaskManager {
	
	private var tasks: [RegularTask]
	
	/// Class initializer
	init() {
		tasks = []
	}
	
	/// Method returning all tasks
	/// - Returns: Task array
	func getAllTasks() -> [RegularTask] {
		tasks
	}

	/// Requests a sorted array of completed tasks
	/// - Returns: Task array
	func getTasksCompleted() -> [RegularTask] {
		tasks.filter { $0.isComplited }
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

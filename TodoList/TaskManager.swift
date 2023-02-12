//
//  TaskManager.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

protocol ITaskManager: AnyObject {
	
	associatedtype Item: ITask
	
	func getAllTasks() -> [Item]
	func getTaskCompleted() -> [Item]
	func getTsksUnCompleted() -> [Item]
	func add(_ task: Item)
	func remove(_ task: Item)
}

final class TaskManager: ITaskManager {
	
	typealias Item = RegularTask
	
	private var tasks: [Item] = []
	
	init() {
		self.tasks = [
			RegularTask(title: "Test"),
			ImportantTask(priorety: .height, isCompleted: true, title: "Important"),
			ImportantTask(priorety: .low, isCompleted: true, title: "Important Low"),
			ImportantTask(title: "Important Regular"),
			ImportantTask(title: "Overdue task", creatDate: Date(timeIntervalSinceReferenceDate: -123456789.0))
		]
	}
	
	/// Get all Task
	func getAllTasks() -> [Item] {
		tasks
	}

	/// Get all Task Completed
	func getTaskCompleted() -> [Item] {
		getAllTasks().filter { $0.isComplited }
	}

	/// Get all Task Un Completed
	func getTsksUnCompleted() -> [Item] {
		getAllTasks().filter { !$0.isComplited }
	}

	/// Add new Task
	func add(_ task: Item) {
		tasks.append(task)
	}

	/// Remove Task
	func remove(_ task: Item) {
		tasks = tasks.filter { $0.id != task.id }
	}
}

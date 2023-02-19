//
//  ImportantTask.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

/// An enumeration describing the priority of task execution
enum Priority: Int, Comparable {
	
	case low = 1
	case normal
	case height
	
	/// Static method to implement comparison
	/// - Parameters:
	///   - lhs: left priority value
	///   - rhs: right priority value
	/// - Returns: Boolean values
	static func < (lhs: Priority, rhs: Priority) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

/// A class describing an important task and its properties
final class ImportantTask: RegularTask {
	
	/// Task priority property
	var priority: Priority
	
	/// A property indicating the due date of the task
	var deadlineDate: Date {
		Calendar.current.date(byAdding: .day, value: priority.rawValue, to: createDate)!
	}
	
	/// An initializer that creates a model of an important task
	/// - Parameters:
	///   - priorety: Current task priority
	///   - isCompleted: Task completion status
	///   - title: Title describing the task
	///   - creatDate: Task creation date
	init(priorety: Priority = .normal, isCompleted: Bool = false, title: String, creatDate: Date = Date()) {
		self.priority = priorety
		super.init(isCompleted: isCompleted,title: title, createDate: creatDate)
	}
}

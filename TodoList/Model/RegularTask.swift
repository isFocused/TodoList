//
//  RegularTask.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

/// Class describing a regular task and its properties
class RegularTask: Identifiable {
	
	/// Issue ID property
	var id: UUID
	/// A property indicating the completion of a task
	var isComplited: Bool
	/// Task description property
	var title: String
	/// The property describes the date the task was created
	let createDate: Date
	
	/// Initializer that creates regular tasks
	/// - Parameters:
	///   - isCompleted: Status indicating whether the task has been completed
	///   - title: Task title
	///   - createDate: Date of creation
	init(isCompleted: Bool = false, title: String, createDate: Date = Date()) {
		id = UUID()
		self.isComplited = isCompleted
		self.title = title
		self.createDate = createDate
	}
}

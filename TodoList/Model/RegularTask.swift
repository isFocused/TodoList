//
//  RegularTask.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

protocol ITask: Identifiable {
	
	var isComplited: Bool { get set }
	var title: String { get set }
}

class RegularTask: ITask {
	
	var isComplited: Bool
	var title: String
	let createDate: Date
	
	init(isCompleted: Bool = false, title: String, createDate: Date = Date()) {
		self.isComplited = isCompleted
		self.title = title
		self.createDate = createDate
	}
}

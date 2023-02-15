//
//  ImportantTask.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

enum Priority: Int, Comparable {
	
	case low = 1
	case normal
	case height
	
	static func < (lhs: Priority, rhs: Priority) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

final class ImportantTask: RegularTask {
	
	var priority: Priority
	
	var deadlineDate: Date {
		Calendar.current.date(byAdding: .day, value: priority.rawValue, to: createDate)!
	}
	
	init(priorety: Priority = .normal, isCompleted: Bool = false, title: String, creatDate: Date = Date()) {
		self.priority = priorety
		super.init(isCompleted: isCompleted,title: title, createDate: creatDate)
	}
}

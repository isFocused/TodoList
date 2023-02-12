//
//  ImportantTask.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

enum Priority: Int {
	
	case low = 1
	case normal
	case height
	
	var nameImage: String {
		switch self {
		case .low:
			return "low-priority"
		case .normal:
			return "medium-priority"
		case .height:
			return "high-priority"
		}
	}
}

final class ImportantTask: RegularTask {
	
	var priorety: Priority
	
	var deadlineDate: Date {
		Calendar.current.date(byAdding: .day, value: priorety.rawValue, to: createDate)!
	}
	
	init(priorety: Priority = .normal, isCompleted: Bool = false, title: String, creatDate: Date = Date()) {
		self.priorety = priorety
		super.init(isCompleted: isCompleted,title: title, createDate: creatDate)
	}
}

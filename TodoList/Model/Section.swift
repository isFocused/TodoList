//
//  Section.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

enum Section {
	
	case completed([RegularTask])
	case uncompleted([RegularTask])
	
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

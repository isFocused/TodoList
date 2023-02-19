//
//  ListSectionPresenter.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

/// Section presenter
enum ListSectionPresenter {
	
	case completed([IListRegularPresentorCell])
	case uncompleted([IListRegularPresentorCell])
	
	/// The property describes the title of the section
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

//
//  ListController.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

protocol IlistController {
	
	func cellForRowAt(indexPath: IndexPath) -> Tasks?
	func numberOfRowsInSection() -> Int
}

final class ListController: IlistController {
	
	private let taskManager: any ITaskManager
	private var tasks: [Tasks]
	
	init(taskManager: any ITaskManager = TaskManager()) {
		self.taskManager = taskManager
		self.tasks = taskManager.getAllTasks().compactMap {
			if let model = $0 as? ImportantTask {
				return .important(model)
			} else if let model = $0 as? RegularTask {
				return .regular(model)
			} else {
				return nil
			}
		}
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Tasks? {
		tasks[indexPath.row]
	}
	
	func numberOfRowsInSection() -> Int {
		tasks.count
	}
}

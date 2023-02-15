//
//  ListController.swift
//  TodoList
//
//  Created by Denis Ivanov on 12.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import Foundation

protocol IListController {
	
	func cellForRowAt(indexPath: IndexPath) -> RegularTask
	func numberOfRowsInSection(section: Int) -> Int
	func numberOfSections() -> Int
	func titleForHeaderInSection(section: Int) -> String
	func viewDidLoad()
	func updateData() 
}

final class ListController: IListController {
	
	private let tasksRepository: IRepository
	private var tasks: [Section]
	
	init(tasksRepository: IRepository) {
		self.tasksRepository = tasksRepository
		tasks = []
	}
	
	func viewDidLoad() {
		tasksRepository.createStub()
		updateData()
	}
	
	func numberOfRowsInSection(section: Int) -> Int {
		switch tasks[section] {
		case .completed(let tasks), .uncompleted(let tasks):
			return tasks.count
		}
	}
	
	func cellForRowAt(indexPath: IndexPath) -> RegularTask {
		switch tasks[indexPath.section] {
		case .completed(let tasks), .uncompleted(let tasks):
			return tasks[indexPath.row]
		}
	}
	
	func updateData() {
		tasks = tasksRepository.getSection() as? [Section] ?? []
	}
	
	func numberOfSections() -> Int {
		tasks.count
	}
	
	func titleForHeaderInSection(section: Int) -> String {
		tasks[section].title
	}
}

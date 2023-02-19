//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		let sort = SortedTaskManager(taskManager: TaskManager())
		let repo = TasksRepository(taskManager: sort)
		repo.setTasks()
		let viewController = ListViewController()
		let presentor = ListPresenter(view: viewController, sectionManager: SectionForTaskManagerAdapter(taskManager: sort))
		viewController.presentor = presentor
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
	}
}

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
		let repo = TasksRepository(taskManager: TaskManager())
		let controller = ListController(tasksRepository: repo)
		let viewController = ListViewController()
		viewController.controller = controller
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
	}
}

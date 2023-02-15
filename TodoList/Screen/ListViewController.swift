//
//  ListViewController.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
	
	var controller: IListController?
	
	private var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
	}
}

extension ListViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		controller?.titleForHeaderInSection(section: section)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		controller?.numberOfSections() ?? .zero
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let task = controller?.cellForRowAt(indexPath: indexPath) else { return UITableViewCell() }
		if let importTack = task as? ImportantTask {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ListImportantTaskCell", for: indexPath) as? ListImportantTaskCell
			cell?.setModel(importTack)
			cell?.delegate = self
			return cell ?? UITableViewCell()
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ListRelurTaskCell", for: indexPath) as? ListRelurTaskCell
			cell?.setModel(task)
			cell?.delegate = self
			return cell ?? UITableViewCell()
		}
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		controller?.numberOfRowsInSection(section: section) ?? .zero
	}
}

extension ListViewController: TaskCellDelegate {
	
	func updateAction() {
		controller?.update()
		tableView.reloadData()
	}
}

private extension ListViewController {
	
	func configureViewController() {
		view.backgroundColor = .white
		controller?.viewDidLoad()
		createTableView()
	}
	
	func createTableView() {
		tableView = UITableView(frame: .zero)
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.register(ListRelurTaskCell.self, forCellReuseIdentifier: "ListRelurTaskCell")
		tableView.register(ListImportantTaskCell.self, forCellReuseIdentifier: "ListImportantTaskCell")
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
}

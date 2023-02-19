//
//  ListViewController.swift
//  TodoList
//
//  Created by Denis Ivanov on 11.02.2023.
//  Copyright © 2023 Denis Ivanov. All rights reserved.
//

import UIKit

/// Protocol describing the implementation for accessing the view
protocol IListView: AnyObject {
	
	/// Method to reload table from presenter
	func reloadData()
}

/// Class for displaying table content
final class ListViewController: UIViewController {
	
	var presentor: IListPresenter?
	
	private var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
	}
}

extension ListViewController: IListView {
	
	func reloadData() {
		tableView.reloadData()
	}
}

extension ListViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		presentor?.titleForHeaderInSection(section: section)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		presentor?.numberOfSections() ?? .zero
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let presentorCell = presentor?.cellForRowAt(indexPath: indexPath) else { return UITableViewCell() }
		if presentorCell is ListImportantPresenterCell {
			let cell = tableView.dequeueReusableCell(withIdentifier: ListImportantTaskCell.identifier, for: indexPath) as? ListImportantTaskCell
			cell?.setPresenter(presentorCell)
			return cell ?? UITableViewCell()
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: ListRegularTaskCell.identifier, for: indexPath) as? ListRegularTaskCell
			cell?.setPresenter(presentorCell)
			return cell ?? UITableViewCell()
		}
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presentor?.numberOfRowsInSection(section: section) ?? .zero
	}
}

private extension ListViewController {
	
	func configureViewController() {
		view.backgroundColor = .white
		presentor?.fetchTasks()
		createTableView()
	}
	
	func createTableView() {
		tableView = UITableView(frame: .zero)
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.register(ListRegularTaskCell.self, forCellReuseIdentifier: ListRegularTaskCell.identifier)
		tableView.register(ListImportantTaskCell.self, forCellReuseIdentifier: ListImportantTaskCell.identifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
}

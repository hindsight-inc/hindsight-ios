//
//  ListViewController.swift
//  hindsight
//
//  Created by Leo on 2/3/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

	@IBOutlet var tableView: UITableView!

	var viewModel: ListViewModelProtocol!

	/*
	init(viewModel: ListViewModelProtocol) {
	self.viewModel = viewModel
	super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
	fatalError("init(coder:) has not been implemented")
	}
	*/

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.setup()
	}
}

//
//  DetailViewController.swift
//  hindsight
//
//  Created by Leo on 2/9/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var contentLabel: UILabel!
	@IBOutlet var authorLabel: UILabel!
	@IBOutlet var dateLabel: UILabel!

	var viewModel: DetailViewModelProtocol!
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.setup()

		viewModel.topic.asObservable()
			.subscribe(onNext: { topic in
				self.titleLabel.text = topic.title
				self.contentLabel.text = topic.content
				self.authorLabel.text = topic.author?.username
				self.dateLabel.text = topic.milestone_deadline
			})
			.disposed(by: disposeBag)

		viewModel.comments.asObservable()
			.bind(to: tableView.rx.items(
				cellIdentifier: "DetailCommentCell", cellType: UITableViewCell.self)) { (_, _, _) in
					/*
					cell.titleLabel.text = topic.title
					cell.contentLabel.text = topic.content
					cell.authorLabel.text = topic.author?.username
					cell.dateLabel.text = topic.milestone_deadline
					*/
			}
			.disposed(by: disposeBag)

		tableView.rx
			.modelSelected(TopicResponse.self)
			.subscribe(onNext: { topic in
				print("DETAIL selected", topic)
				//self.viewModel.nextClosure(topic)
			})
			.disposed(by: disposeBag)

		tableView.rx
			.itemSelected
			.subscribe(onNext: { [weak self] indexPath in
				print("DETAIL tapped", indexPath.row)
				self?.tableView.deselectRow(at: indexPath, animated: true)
			})
			.disposed(by: disposeBag)
	}
}

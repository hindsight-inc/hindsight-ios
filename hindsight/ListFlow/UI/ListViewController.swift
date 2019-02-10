//
//  ListViewController.swift
//  hindsight
//
//  Created by Leo on 2/3/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import UIKit
import RxSwift

class ListTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
}

class ListViewController: UIViewController {

	// TODO: @Manish reconstruct UI programmatically if you want
	@IBOutlet var tableView: UITableView!

	var viewModel: ListViewModelProtocol!
    private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.setup()

        viewModel.topics.asObservable()
            .bind(to: tableView.rx.items(
                cellIdentifier: "ListTopicCell", cellType: ListTableViewCell.self)) { (_, topic, cell) in

                cell.titleLabel.text = topic.title
                cell.contentLabel.text = topic.content
                cell.authorLabel.text = topic.author?.username
                cell.dateLabel.text = topic.milestone_deadline
            }
            .disposed(by: disposeBag)

        tableView.rx
            .modelSelected(TopicResponse.self)
            .subscribe(onNext: { topic in
                print("LIST selected", topic)
				self.viewModel.nextClosure(topic)
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                print("LIST tapped", indexPath.row)
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

//
//  LoginButton.swift
//  hindsight
//
//  Created by Wei-Ting Lin on 11/12/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

/// This UIView is created to match the design and can be reused in the future
/// - Ex: Google Login, Instagram Login
class LoginButton: UIView {

    let viewModel: LoginButtonProtocol

    let disposeBag = DisposeBag()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    init(viewModel: LoginButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUpUI()
        setUpConstraints()
        bindView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleLongPressGestureRecognizer(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.viewModel.didSelect()
        case .cancelled:
            self.viewModel.didCancel()
        case .ended:
            self.viewModel.didRelease()
        default:
            break
        }
    }

    private func bindView() {
        viewModel
            .buttonState
            .asDriver()
            .drive(onNext: { [unowned self] state in
            self.update(to: state)
        })
            .disposed(by: disposeBag)
    }

    private func update(to state: LoginButtonStateProtocol) {
        backgroundColor = state.backgroundColor
        titleLabel.textColor = state.textColor
        titleLabel.text = state.text
        imageView.image = state.image
    }

    private func setUpUI() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
            action: #selector(self.handleLongPressGestureRecognizer))
        longPressGestureRecognizer.minimumPressDuration = 0
        addSubview(titleLabel)
        addSubview(imageView)
        addGestureRecognizer(longPressGestureRecognizer)
        layer.cornerRadius = 5
        isUserInteractionEnabled = true
        clipsToBounds = true
    }

    private func setUpConstraints() {
        let margin = 10
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(margin)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(imageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(margin)
            make.trailing.equalTo(self.snp.trailing).offset(-margin)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}

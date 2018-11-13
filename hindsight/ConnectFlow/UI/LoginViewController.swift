//
//  LoginViewController.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    let viewModel: LoginViewModelProtocol

    let disposeBag = DisposeBag()

    lazy var logoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var facebookConnect: HindsightLoginButton = {

        let normalState = LoginButtonState(text: "Login With Facebook",
                                           textColor: ColorName.hindsightWhite.color,
                                           backgroundColor: ColorName.facebookButtonStateNormal.color,
                                           image: Asset.facebookLogo.image)
        let highlightState = LoginButtonState(backgroundColor: ColorName.facebookButtonStateHighlight.color)
        let buttonViewModel = LoginButtonViewModel(normalState: normalState,
                                                   highlightState: highlightState,
                                                   didSelectClosure: { [unowned self] in
            self.viewModel.connectFacebook()
        })
        let button = HindsightLoginButton(viewModel: buttonViewModel)
        return button
    }()

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(facebookConnect)
        logoImageView.image = Asset.hindsightLogo.image
        backgroundImageView.image = Asset.hindsightLoginBackground.image
        backgroundImageView.contentMode = .scaleAspectFill
    }

    func setupConstraints() {
        let margin = 20
        let buttonHeight = 50
        backgroundImageView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(view.snp.top)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(margin)
        }
        facebookConnect.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(margin)
            make.trailing.equalTo(view.snp.trailing).offset(-margin)
            make.bottom.equalTo(view.snp.bottom).offset(-margin)
            make.height.equalTo(buttonHeight)
        }
    }
}

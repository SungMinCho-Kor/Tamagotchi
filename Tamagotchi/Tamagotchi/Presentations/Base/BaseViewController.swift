//
//  BaseViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit

class BaseViewController: UIViewController, ViewConfiguration {
    init() {
        super.init(nibName: nil, bundle: nil)
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceSetting()
        configureHierarchy()
        configureLayout()
        configureViews()
        configureNavigation()
        bind()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureViews() { }
    func bind() { }
    func configureNavigation() { }
    private func serviceSetting() {
        view.backgroundColor = .serviceBackground
        navigationController?.navigationBar.tintColor = .servicePrimary
    }
}

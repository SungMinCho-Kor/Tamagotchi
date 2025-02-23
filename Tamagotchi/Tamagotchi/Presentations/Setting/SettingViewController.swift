//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SettingViewModel()
    
    private let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureViews() {
        tableView.backgroundColor = .serviceBackground
        tableView.separatorInset = .zero
        tableView.register(
            SettingTableViewCell.self,
            forCellReuseIdentifier: SettingTableViewCell.identifier
        )
    }
    
    override func configureNavigation() {
        navigationItem.title = "설정"
    }
    
    override func bind() {
        let output = viewModel.transform(
            input: SettingViewModel.Input()
        )
        
        output.tableViewItems
            .asDriver()
            .drive(
                tableView.rx.items(
                    cellIdentifier: SettingTableViewCell.identifier,
                    cellType: SettingTableViewCell.self
                )
            ) { row, element, cell in
                cell.configure(content: element)
            }
            .disposed(by: disposeBag)
    }
}

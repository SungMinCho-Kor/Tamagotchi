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
    private let refresh = PublishRelay<Void>()
    
    private let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh.accept(())
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
        let reset = PublishRelay<Void>()
        
        let output = viewModel.transform(
            input: SettingViewModel.Input(
                cellSelected: tableView.rx.itemSelected,
                refresh: refresh,
                reset: reset
            )
        )
        
        output.tableViewItems
            .asDriver(onErrorJustReturn: [])
            .drive(
                tableView.rx.items(
                    cellIdentifier: SettingTableViewCell.identifier,
                    cellType: SettingTableViewCell.self
                )
            ) { row, element, cell in
                cell.configure(content: element)
            }
            .disposed(by: disposeBag)
        
        output.pushChangeMasterNameViewController
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                owner.navigationController?.pushViewController(
                    ChangeMasterNameViewController(),
                    animated: true
                )
            }
            .disposed(by: disposeBag)
        
        output.pushChangeTamagochiViewController
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                owner.navigationController?.pushViewController(
                    CharacterSelectViewController(),
                    animated: true
                )
            }
            .disposed(by: disposeBag)
        
        output.presentResetAlert
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                owner.presentResetAlert(relay: reset)
            }
            .disposed(by: disposeBag)
        
        output.changeRootViewController
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                owner.changeRootViewController(
                    CommonNavigationController(rootViewController: CharacterSelectViewController()),
                    animated: true
                )
            }
            .disposed(by: disposeBag)
    }
    
    private func presentResetAlert(relay: PublishRelay<Void>) {
        let alertController = UIAlertController(
            title: "데이터 초기화",
            message: "정말 다시 처음부터 시작하실 건가용?",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "웅", style: .default) { _ in
            relay.accept(())
        }
        let cancel = UIAlertAction(title: "아냐!", style: .cancel)
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(
            alertController,
            animated: true
        )
    }
}

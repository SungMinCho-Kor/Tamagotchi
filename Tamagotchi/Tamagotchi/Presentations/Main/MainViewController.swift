//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private let refreshCharacter = PublishRelay<Void>()
    
    private let bubbleView = BubbleView()
    private let characterView = CharacterView()
    private let characterInfoLabel = UILabel()
    private let waterFeedingView = FeedingView(feedType: .water)
    private let foodFeedingView = FeedingView(feedType: .food)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshCharacter.accept(())
    }
    
    override func configureHierarchy() {
        [
            bubbleView,
            characterView,
            characterInfoLabel,
            waterFeedingView,
            foodFeedingView
        ].forEach(view.addSubview)
    }
    
    override func configureLayout() {
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(180)
        }
        
        characterView.snp.makeConstraints { make in
            make.top.equalTo(bubbleView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(bubbleView).inset(40)
        }
        
        characterInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(characterView.snp.bottom).offset(16)
            make.centerX.equalTo(characterView)
        }
        
        waterFeedingView.snp.makeConstraints { make in
            make.top.equalTo(characterInfoLabel.snp.bottom).offset(40)
            make.centerX.equalTo(characterView)
        }
        
        foodFeedingView.snp.makeConstraints { make in
            make.top.equalTo(waterFeedingView.snp.bottom).offset(20)
            make.centerX.equalTo(characterView)
        }
    }
    
    override func configureViews() {
        characterInfoLabel.font = .systemFont(ofSize: 15)
        characterInfoLabel.textColor = .servicePrimary
    }
    
    override func configureNavigation() {
        let settingBarButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem = settingBarButton
        
        let backButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem = backButton
    }
    
    override func bind() {
        let waterTapped = waterFeedingView.feedButton.rx.tap
        let waterText = BehaviorRelay(value: "")
        let foodTapped = foodFeedingView.feedButton.rx.tap
        let foodText = BehaviorRelay(value: "")
        
        waterText
            .asDriver()
            .drive(with: self) { owner, text in
                owner.waterFeedingView.amountTextField.text = text
            }
            .disposed(by: disposeBag)
        
        waterFeedingView.amountTextField.rx.text.orEmpty
            .bind(to: waterText)
            .disposed(by: disposeBag)
        
        foodText
            .asDriver()
            .drive(with: self) { owner, text in
                owner.foodFeedingView.amountTextField.text = text
            }
            .disposed(by: disposeBag)
        
        foodFeedingView.amountTextField.rx.text.orEmpty
            .bind(to: foodText)
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(
            input: MainViewModel.Input(
                waterText: waterText,
                waterTapped: waterTapped,
                foodText: foodText,
                foodTapped: foodTapped,
                refreshCharacter: refreshCharacter
            )
        )
        
        output.fetchCharacter
            .asDriver(
                onErrorJustReturn: CharacterInformation(
                    character: .notReady,
                    water: 0,
                    food: 0
                )
            )
            .drive(with: self) { owner, information in
                owner.characterView.configure(
                    imageName: information.imageName,
                    name: information.character.name
                )
                owner.characterInfoLabel.text = "LV\(information.level) · 밥알 \(information.food)개 · 물방울 \(information.water)개"
            }
            .disposed(by: disposeBag)
        
        output.navigationTitle
            .asDriver()
            .drive(with: self) { owner, title in
                owner.navigationItem.title = title
            }
            .disposed(by: disposeBag)
        
        output.showAlert
            .drive(with: self) { owner, message in
                owner.showAlert(message: message)
            }
            .disposed(by: disposeBag)
        
        output.showMessage
            .drive(with: self) { owner, message in
                owner.bubbleView.contentLabel.text = message
            }
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                let settingViewController = SettingViewController()
                owner.navigationController?.pushViewController(
                    settingViewController,
                    animated: true
                )
            }
            .disposed(by: disposeBag)
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "확인",
                style: .default
            )
        )
        present(
            alertController,
            animated: true
        )
    }
}

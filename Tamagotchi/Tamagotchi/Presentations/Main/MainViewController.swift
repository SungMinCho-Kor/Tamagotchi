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
    
    private let bubbleView = BubbleView()
    private let characterView = CharacterView()
    private let characterInfoLabel = UILabel()
    private let waterFeedingView = FeedingView(feedType: .water)
    private let foodFeedingView = FeedingView(feedType: .food)
    
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
        
    }
    
    override func configureNavigation() {
        super.configureNavigation()
    }
    
    override func bind() {
        let output = viewModel.transform(
            input: MainViewModel.Input(
                
            )
        )
        
        output.fetchCharacter
            .drive(with: self) { owner, information in
                owner.characterView.configure(
                    imageName: information.imageName,
                    name: information.character.name
                )
            }
            .disposed(by: disposeBag)
    }
}

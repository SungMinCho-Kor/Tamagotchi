//
//  SelectionModalViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SelectDelegate: AnyObject {
    func select(character: TamagotchiCharacter)
}

final class SelectionModalViewController: BaseViewController {
    private let viewModel: SelectionModalViewModel
    private let disposeBag = DisposeBag()
    
    private let containerView = UIView()
    private let characterView = CharacterView()
    private let dividerView = UIView()
    private let descriptionLabel = UILabel()
    private let cancelButton = UIButton()
    private let selectButton = UIButton()
    
    weak var delegate: SelectDelegate?
    
    init(viewModel: SelectionModalViewModel) {
        self.viewModel = viewModel
        super.init()
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func configureHierarchy() {
        view.addSubview(containerView)
        [
            characterView,
            dividerView,
            descriptionLabel,
            cancelButton,
            selectButton
        ].forEach(containerView.addSubview)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        characterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(characterView.snp.width).offset(40)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(characterView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(dividerView)
            make.bottom.equalTo(cancelButton.snp.top).inset(8)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.trailing.equalTo(containerView.snp.centerX)
            make.height.equalTo(60)
        }
        
        selectButton.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.centerX)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.backgroundColor = .serviceBackground
        
        dividerView.backgroundColor = .servicePrimary
        
        descriptionLabel.textColor = .servicePrimary
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14)
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.servicePrimary, for: .normal)
        cancelButton.backgroundColor = .serviceDarkBackground
        selectButton.setTitleColor(.servicePrimary, for: .normal)
    }
    
    override func bind() {
        let output = viewModel.transform(
            input: SelectionModalViewModel.Input(
                select: selectButton.rx.tap,
                cancel: cancelButton.rx.tap
            )
        )
        
        output.selectButtonTitle
            .asDriver(onErrorJustReturn: "변경하기")
            .drive(selectButton.rx.title())
            .disposed(by: disposeBag)
        
        output.character
            .asDriver(onErrorJustReturn: .notReady)
            .drive(with: self) { owner, character in
                owner.characterView.configure(
                    imageName: character.imageName,
                    name: character.name
                )
                owner.descriptionLabel.text = character.description
            }
            .disposed(by: disposeBag)
        
        output.cancel
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.selectCharacter
            .asDriver(onErrorJustReturn: .notReady)
            .drive(with: self) { owner, character in
                owner.delegate?.select(character: character)
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

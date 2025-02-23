//
//  ChangeMasterNameViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ChangeMasterNameViewController: BaseViewController {
    private let viewModel = ChangeMasterNameViewModel()
    private let disposeBag = DisposeBag()
    
    private let nameTextField = UITextField()
    private let nameTextFieldBottomLineView = UIView()
    
    override func configureHierarchy() {
        [
            nameTextField,
            nameTextFieldBottomLineView
        ].forEach(view.addSubview)
    }
    
    override func configureLayout() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        nameTextFieldBottomLineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(nameTextField)
            make.height.equalTo(1)
        }
    }
    
    override func configureViews() {
        nameTextField.placeholder = "2~6 글자 이름 입력"
        nameTextField.textColor = .servicePrimary
        
        nameTextFieldBottomLineView.backgroundColor = .servicePrimary
    }
    
    override func configureNavigation() {
        navigationItem.title = "대장님 이름 정하기"
        
        let saveBarButton = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem = saveBarButton
    }

    override func bind() {
        guard let saveButton = navigationItem.rightBarButtonItem else {
            print(#function, "No Save Button")
            return
        }
        
        let output = viewModel.transform(
            input: ChangeMasterNameViewModel.Input(
                nameInput: nameTextField.rx.text.orEmpty,
                saveButtonTapped: saveButton.rx.tap
            )
        )
        
        output.name
            .asDriver()
            .drive(with: self) { owner, name in
                owner.nameTextField.text = name
            }
            .disposed(by: disposeBag)
        
        output.saveButtonValidation
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, isValid in
                saveButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)
        
        output.save
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

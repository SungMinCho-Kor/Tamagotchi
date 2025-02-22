//
//  FeedingView.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import UIKit
import SnapKit

final class FeedingView: BaseView {
    
    enum FeedType {
        case food
        case water
        
        var placeholder: String {
            switch self {
            case .food:
                return "밥주세용"
            case .water:
                return "물주세용"
            }
        }
        
        var systemImageName: String {
            switch self {
            case .food:
                return "leaf.circle"
            case .water:
                return "drop.circle"
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .food:
                return "밥먹기"
            case .water:
                return "물먹기"
            }
        }
    }
    
    private let textFieldLineView = UIView()
    
    let amountTextField = UITextField()
    let feedButton = UIButton()
    
    init(feedType: FeedType) {
        super.init()
        configureViews(feedType: feedType)
    }
    
    override func configureHierarchy() {
        [
            amountTextField,
            textFieldLineView,
            feedButton
        ].forEach(addSubview)
    }
    
    override func configureLayout() {
        textFieldLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(200)
            make.leading.bottom.equalToSuperview()
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(textFieldLineView.snp.top).offset(-4)
            make.centerX.equalTo(textFieldLineView)
            make.horizontalEdges.equalTo(textFieldLineView).inset(16)
            make.height.equalTo(40)
        }
        
        feedButton.snp.makeConstraints { make in
            make.leading.equalTo(textFieldLineView.snp.trailing).offset(16)
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    override func configureViews() {
        backgroundColor = .serviceBackground
        
        textFieldLineView.backgroundColor = .servicePrimary
        
        amountTextField.textAlignment = .center
        amountTextField.textColor = .servicePrimary
        amountTextField.keyboardType = .numberPad
        
        feedButton.configuration = UIButton.Configuration.bordered()
        feedButton.configuration?.baseBackgroundColor = .serviceBackground
        feedButton.configuration?.baseForegroundColor = .servicePrimary
        
        feedButton.layer.cornerRadius = 10
        feedButton.layer.borderWidth = 1
        feedButton.layer.borderColor = UIColor.servicePrimary.cgColor
        feedButton.clipsToBounds = true
    }
    
    private func configureViews(feedType: FeedType) {
        amountTextField.placeholder = feedType.placeholder
        
        feedButton.configuration?.image = UIImage(systemName: feedType.systemImageName)
//        feedButton.configuration?.imagePlacement = .leading
        feedButton.configuration?.title = feedType.buttonTitle
    }
}

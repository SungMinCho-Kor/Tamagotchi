//
//  CharacterSelectViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CharacterSelectViewController: BaseViewController {
    private let viewModel = CharacterSelectViewModel(isOnboarding: true)
    private lazy var characterCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )
    private let disposeBag = DisposeBag()
    
    override func configureHierarchy() {
        view.addSubview(characterCollectionView)
    }
    
    override func configureLayout() {
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureViews() {
        characterCollectionView.backgroundColor = .clear
        characterCollectionView.register(
            CharacterSelectCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterSelectCollectionViewCell.identifier
        )
    }
    
    override func bind() {
        let output = viewModel.transform(
            input: CharacterSelectViewModel.Input(
                
            )
        )
        
        output.characters
            .asDriver(onErrorJustReturn: [])
            .drive(
                characterCollectionView.rx.items(
                    cellIdentifier: CharacterSelectCollectionViewCell.identifier,
                    cellType: CharacterSelectCollectionViewCell.self
                )
            ) { row, element, cell in
                cell.configure(
                    content: CharacterSelectCollectionViewCell.Content(
                        imageName: element.imageName,
                        name: element.name
                    )
                )
            }
            .disposed(by: disposeBag)
        
        output.navigationTitle
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, value in
                owner.navigationItem.title = value
            }
            .disposed(by: disposeBag)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        let width = UIScreen.main.bounds.width
        let cellWidth: CGFloat = (width - 20*5)/3
        
        layout.itemSize = CGSize(
            width: cellWidth,
            height: cellWidth + 40
        )
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        
        return layout
    }
}

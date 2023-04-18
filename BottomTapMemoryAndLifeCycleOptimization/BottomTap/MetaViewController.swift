//
//  MetaViewController.swift
//  BottomTapMemoryAndLifeCycleOptimization
//
//  Created by 도학태 on 2023/04/18.
//

import Foundation
import UIKit
import RxGesture
import RxSwift
import RxCocoa



class MetaViewController : BaseViewController {
    let disposeBag = DisposeBag()
    
    let closeButton = UIImageView().then {
        $0.image = UIImage(systemName: "xmark")
    }
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = "META"
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        
        closeButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext : { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    override func attrubute() {
        super.attrubute()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    override func layout() {
        super.layout()
        
        [
            label
        ].forEach {
            view.addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

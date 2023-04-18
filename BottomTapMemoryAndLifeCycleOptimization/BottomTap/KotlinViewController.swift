//
//  KotlinViewController.swift
//  BottomTapMemoryAndLifeCycleOptimization
//
//  Created by 도학태 on 2023/04/18.
//

import Foundation
import Then
import SnapKit


class KotlinViewController : BaseViewController {
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = "KOTLIN"
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

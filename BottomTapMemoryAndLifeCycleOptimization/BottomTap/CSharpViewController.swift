//
//  CSharpViewController.swift
//  BottomTapMemoryAndLifeCycleOptimization
//
//  Created by 도학태 on 2023/04/18.
//

import Foundation
import UIKit



class CSharpViewController : BaseViewController {
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = "C_SHARP"
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

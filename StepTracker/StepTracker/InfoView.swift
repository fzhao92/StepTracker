//
//  InfoView.swift
//  StepTracker
//
//  Created by Forrest Zhao on 7/4/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

class InfoView: UIView {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var contentValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    lazy var contentTypeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .clear
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        self.addSubview(contentValueLabel)
        contentValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        self.addSubview(contentTypeLabel)
        contentTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentValueLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(contentValueLabel)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

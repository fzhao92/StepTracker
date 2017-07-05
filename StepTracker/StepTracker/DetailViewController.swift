//
//  DetailViewController.swift
//  StepTracker
//
//  Created by Forrest Zhao on 7/4/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var dailyActivity: DailyActivity!
    
    lazy var floorsView: InfoView = {
        let view = InfoView()
        view.imageView.image = #imageLiteral(resourceName: "stairsIcon")
        view.contentTypeLabel.text = "floors"
        return view
    }()
    
    lazy var stepsView: InfoView = {
        let view = InfoView()
        view.imageView.image = #imageLiteral(resourceName: "footprintsIcon")
        view.contentTypeLabel.text = "steps"
        return view
    }()
    
    lazy var distanceView: InfoView = {
        let view = InfoView()
        view.imageView.image = #imageLiteral(resourceName: "distanceIcon")
        view.contentTypeLabel.text = "miles"
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .green
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        implStackView()
        
    }
    
    func implStackView() {
        
        let views = [stepsView, floorsView, distanceView]
        
        stepsView.contentValueLabel.text = dailyActivity.getStepCountStr()
        floorsView.contentValueLabel.text = dailyActivity.getFloorsStr()
        distanceView.contentValueLabel.text = dailyActivity.getDistanceStr()
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(stackView.snp.width).multipliedBy(0.5)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

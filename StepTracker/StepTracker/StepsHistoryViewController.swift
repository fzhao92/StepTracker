//
//  ViewController.swift
//  StepTracker
//
//  Created by Forrest Zhao on 6/30/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let reuseId = "cell"

class StepsHistoryViewController: UIViewController {
    
    lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var pedometer: Pedometer!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addObserver(self, forKeyPath: #keyPath(pedometer.reloadDataRequired), options: [.new], context: nil)
        view.backgroundColor = .white
        
        setupTableView()
        
        pedometer.retrieveSteps(forPastXDays: 10)
        
    }
    
    func setupTableView() {
        
        view.addSubview(historyTableView)
        historyTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(pedometer.reloadDataRequired))
    }
    
    // - MARK: observer pedometer class and reload tableview if there is new data
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(pedometer.reloadDataRequired) {
            
            if let newVal = change?[NSKeyValueChangeKey.newKey] as? Bool {
                
                if newVal {
                    refreshData()
                }
                
            }
            
        }
    }
    
    private func refreshData() {
        pedometer.reloadDataRequired = false
        historyTableView.reloadData()
    }

}

extension StepsHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension StepsHistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedometer.activityHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activity = pedometer.activityHistory[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseId)
        }
        cell!.textLabel?.text = activity.getDateStr()
        cell?.detailTextLabel?.text = activity.getStepCountStr()
        return cell!
    }
    
}


//
//  TableViewController.swift
//  AlamofireWithTableViewExample
//
//  Created by Hen Levy on 14/10/2015.
//  Copyright © 2015 Hen Levy. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var dataSource: [(name: String, description: String)] = [] // array of tuples
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRefreshControl() {
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
    }
    
    // MARK: TableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DataCell", forIndexPath: indexPath)
        
        let tuple = dataSource[indexPath.row];
        cell.textLabel?.text = tuple.name
        cell.detailTextLabel?.text = tuple.description
        
        return cell
    }
    
    // MARK: WS
    
    func requestData() {
        Alamofire.request(.GET, "http://httpbin.org/get").responseJSON { [weak self] response in

            guard let strongSelf = self, jsonResult = response.result.value as? Dictionary<String, AnyObject> else {
                return
            }
            
            print(jsonResult.debugDescription)
            strongSelf.dataSource.removeAll()
            
            for (key, value) in jsonResult {
                strongSelf.dataSource.append((name: key, description: value.description))
            }
            
            dispatch_async(dispatch_get_main_queue(), { [weak self] () in
                
                guard let strongSelf = self else {
                    return
                }
                strongSelf.refreshControl?.endRefreshing()
                strongSelf.tableView.reloadData()
            })
        }
    }
    
    // MARK: Events
    
    func refresh(sender: AnyObject) {
        requestData()
    }
}


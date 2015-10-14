//
//  DataDescriptionController.swift
//  AlamofireWithTableViewExample
//
//  Created by Hen Levy on 14/10/2015.
//  Copyright © 2015 Hen Levy. All rights reserved.
//

import UIKit

class DataDescriptionController: UIViewController {

    @IBOutlet var descriptionTextView: UITextView!
    
    var descriptionText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionTextView.text = descriptionText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

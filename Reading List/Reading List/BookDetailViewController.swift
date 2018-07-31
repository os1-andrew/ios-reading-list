//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Andrew Liao on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func save(_ sender: Any) {
    }
    

    @IBOutlet weak var reasonLabel: UITextView!
    @IBOutlet weak var bookTitleLabel: UITextField!
}

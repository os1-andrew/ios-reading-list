//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Andrew Dhan on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {


    @IBAction func toggleHasRead(_ sender: Any) {
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!

    @IBOutlet weak var checkBoxButton: UIButton!
    
}

//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Andrew Liao on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    func updateViews(){
        guard let book = book else {return}
        bookTitleLabel.text = book.title
        let imageName = book.hasBeenRead ? "checked" : "unchecked"

        checkBoxButton.setImage(UIImage(named: imageName), for: .normal)

    }
    
    @IBAction func toggleHasRead(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!

    @IBOutlet weak var checkBoxButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book?{
        didSet{
            updateViews()
        }
    }
    
}

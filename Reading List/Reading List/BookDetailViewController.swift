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
        updateViews()
    }
    
    func updateViews(){
        if let book = book{
            self.title = book.title
            bookTitleLabel.text = book.title
            reasonLabel.text = book.reasonToRead
        } else{
            self.title = "Add a new book"
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let title = bookTitleLabel.text,
            let reason = reasonLabel.text else {return}
        
        //does nothing if empty title
        if title == "" {return}
        if let book = book{
            //if not nil, it means that trying to update
            bookController?.updateBook(originalBook: book, newTitle: title, newReason: reason)
        } else {
            bookController?.createBook(withTitle: title, reasonToRead: reason)
            print("create")
        }
        navigationController?.popViewController(animated: true)
        print(bookController?.books.count)
    }
    
    var book:Book?
    var bookController: BookController?
    @IBOutlet weak var reasonLabel: UITextView!
    @IBOutlet weak var bookTitleLabel: UITextField!
}

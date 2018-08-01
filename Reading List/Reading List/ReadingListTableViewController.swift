//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Andrew Liao on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
        tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        cell.book = bookController.updateHasBeenRead(for: cell.book!)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Read Books" : "Unread Books"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else{
            return bookController.unreadBooks.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell
            else {return UITableViewCell()}
        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //MARK: - Helper Function
    private func bookFor(indexPath: IndexPath) -> Book{
        if indexPath.section == 0{
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }

    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? BookDetailViewController else {return}
        
        
        if segue.identifier == "AddBook" {
            destinationVC.bookController = bookController
        } else if segue.identifier == "ViewDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.bookController = bookController
            destinationVC.book = bookFor(indexPath: indexPath)
        }
    }

    //Mark: - Properties
    var bookController = BookController()
}

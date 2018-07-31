//
//  BookController.swift
//  Reading List
//
//  Created by Andrew Liao on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController{
    
    //Mark: - Persistence
    
    func saveToPersistentStore(){
        let encoder = PropertyListEncoder()
        do{
            //encoder econdes the book array and stores it in data
            let booksData = try encoder.encode(books)
            guard let url = readingListURL else {return}
            try booksData.write(to: url)
        } catch {
            NSLog("Error encoding...")
        }
    }
    
    func loadFromPersistentStore(){
        //create fileManager so you can check if the file exists
        let fm = FileManager()
        
        //checks that readingListURL is not nil and checks that the file exists
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else {return}
        
        //creates decoder
        let decoder = PropertyListDecoder()
        do{
            let data = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: data)
        } catch {
            NSLog("Error decoding")
        }
    }
    
    //Mark: - CRUD Methods
    
    func createBook(withTitle title: String, reasonToRead reason: String){
        let newBook = Book(title: title, reasonToRead: reason)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func deleteBook(book:Book){
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateBook(originalBook book:Book, newTitle title:String, newReason reason: String){
        guard let index = books.index(of: book) else {return}

        books[index].title = title
        books[index].reasonToRead = reason
        
//        var temp = books[index]
//        temp.title = title
//        temp.reasonToRead = reason
//        books.remove(at: index)
//        books.insert(temp, at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book:Book ){
        guard let index = books.index(of: book) else {return}
        if books[index].hasBeenRead{
            books[index].hasBeenRead = false
        } else {
            books[index].hasBeenRead = true
        }
        saveToPersistentStore()
    }
    
    //Mark: - Computed Properties
    private var readingListURL: URL? {
        let fm = FileManager.default // why .default??
        
        //Don't understand the parameters below. What does .something mean?
        guard let documentDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil //what are some situations where nil would be returned?
        }
        
        let filename = "ReadingList.plist"
        
        return documentDir.appendingPathComponent(filename)
    }
    
    private var readBooks: [Book]{
        return books.filter{$0.hasBeenRead == true }
    }
    private var unreadBooks: [Book]{
        return books.filter{$0.hasBeenRead == false}
    }
    
    //Mark: - Properties
    private(set) var books = [Book]()
   
}


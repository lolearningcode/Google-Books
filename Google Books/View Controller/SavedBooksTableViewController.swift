//
//  SavedBooksTableViewController.swift
//  Google Books
//
//  Created by Lo Howard on 9/14/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class SavedBooksTableViewController: UITableViewController {
    
    var coreBooks = [BooksCD]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coreBooks = CoreDataBooks.shared.load()
        print(coreBooks.count)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coreBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentBooksTableViewCell", for: indexPath) as! RecentBooksTableViewCell
        
        let books = coreBooks[indexPath.row]
        
        cell.authorLabel.text = books.authors
        cell.bookTitleLabel.text = books.title
        cell.bookDescriptionLabel.text = books.bookDescription
        cell.ratingsLabel.text = "\(books.averageRating)/5"
        cell.bookImageView.image = UIImage(data: books.image!)
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = coreBooks[indexPath.row]
            CoreDataBooks.shared.delete(book)
            coreBooks.remove(at: indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

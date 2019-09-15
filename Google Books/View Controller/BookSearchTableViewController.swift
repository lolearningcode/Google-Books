//
//  BookSearchTableViewController.swift
//  Google Books
//
//  Created by Lo Howard on 9/13/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class BookSearchTableViewController: UITableViewController {
    
    @IBOutlet weak var emptyResultsLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var bookResults: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMain()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookSearchTableViewCell", for: indexPath) as! BookSearchTableViewCell
        let items = bookResults[indexPath.row]
        cell.item = items

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let item = bookResults[indexPath.row]
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func setUpMain() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books..."
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    
}

extension BookSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        BooksController.shared.fetchBooks(books: searchText) { (books) in
            DispatchQueue.main.async {
                self.bookResults = books
                
                if !books.isEmpty {
                    self.emptyResultsLabel.isHidden = true
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
}

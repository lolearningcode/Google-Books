//
//  BookSearchTableViewCell.swift
//  Google Books
//
//  Created by Lo Howard on 9/13/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class BookSearchTableViewCell: UITableViewCell {
    
    var item: Item! {
        didSet {
            BooksController.shared.fetchBookImage(bookItems: item.volumeInfo) { (image) in
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                    self.updateViews()
                }
            }
        }
    }
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func updateViews() {
        guard let item = item, let rating = item.volumeInfo.averageRating else { return }
        self.bookTitleLabel.text = item.volumeInfo.title
        self.bookAuthorLabel.text = item.volumeInfo.authors.first
        self.bookDescriptionLabel.text = item.volumeInfo.volumeInfoDescription
        self.ratingLabel.text = "\(rating)/5"
    }
}

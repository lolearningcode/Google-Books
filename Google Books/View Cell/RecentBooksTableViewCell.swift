//
//  RecentBooksTableViewCell.swift
//  Google Books
//
//  Created by Lo Howard on 9/14/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class RecentBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
//    var item: BooksCD! {
//        didSet {
//            BooksController.shared.fetchBookImage(bookItems: item.) { (image) in
//                self.bookImageView.image = image
//                self.updateViews()
//            }
//        }
//    }
//
//    func updateViews() {
//        guard let item = item, let rating = item.volumeInfo.averageRating else { return }
//        self.bookTitleLabel.text = item.volumeInfo.title
//        self.authorLabel.text = item.volumeInfo.authors.first
//        self.bookDescriptionLabel.text = item.volumeInfo.volumeInfoDescription
//        self.ratingsLabel.text = "Rating: \(rating)"
//    }
}

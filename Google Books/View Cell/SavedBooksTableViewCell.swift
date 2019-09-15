//
//  SavedBooksTableViewCell.swift
//  Google Books
//
//  Created by Lo Howard on 9/14/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class SavedBooksTableViewCell: UITableViewCell {
    
    var item: Item! {
        didSet {
            BooksController.shared.fetchBookImage(bookItems: item) { (image) in
                DispatchQueue.main.async {
                    self.bookImageView.image = image
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
        
    }
}

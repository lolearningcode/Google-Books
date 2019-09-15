//
//  DetailViewController.swift
//  Google Books
//
//  Created by Lo Howard on 9/13/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: Item! {
        didSet {
            BooksController.shared.fetchBookImage(bookItems: item.volumeInfo) { (image) in
                DispatchQueue.main.async {
                    self.bookImage.image = image
                    self.updateViews()
                }
            }
        }
    }
    
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let item = item else { return }
        self.bookTitleLabel.text = item.volumeInfo.title
        self.authorLabel.text = item.volumeInfo.authors.first
        self.bookDescriptionLabel.text = item.volumeInfo.volumeInfoDescription
        //        self.ratingLabel.text = "Rating: \(rating)"
    }
    
    @IBAction func addToCoreData(_ sender: UIButton) {
        CoreDataBooks.shared.save(item.volumeInfo)
        
        print(item.volumeInfo.imageLinks.thumbnail)
    }
}

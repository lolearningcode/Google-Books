//
//  BooksController.swift
//  Google Books
//
//  Created by Lo Howard on 9/13/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

typealias BooksHandler = ([Item]) -> Void
typealias ImageHandler = (UIImage?) -> Void

final class BooksController {
    
    static let shared = BooksController()
    
    func fetchBooks(books: String, completion: @escaping BooksHandler) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?") else { return }
        
        var componenets = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
        let bookSearchItem = URLQueryItem(name: "q", value: books)
        
        componenets?.queryItems = [bookSearchItem]
        
        guard let finalURL = componenets?.url else { completion([]); return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("😢 failed data task \(error)")
                completion([])
                return
            }
            
            guard let data = data else { return }
            
            do {
                let topLevelJson = try JSONDecoder().decode(Books.self, from: data)
                let items = topLevelJson.items
                completion(items)
            } catch {
                print(error.localizedDescription)
                completion([])
                return
            }
            
        }.resume()
    }
    
    func fetchBookImage(bookItems: VolumeInfo, completion: @escaping ImageHandler) {
        guard let url = URL(string: bookItems.imageLinks.smallThumbnail) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
}

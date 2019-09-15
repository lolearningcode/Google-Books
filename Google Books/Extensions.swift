//
//  Extensions.swift
//  Google Books
//
//  Created by Lo Howard on 9/14/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit

extension UIImage {
    
    var toData: Data? {
        return pngData()
    }
    
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}

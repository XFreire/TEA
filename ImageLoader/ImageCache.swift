//
//  ImageCache.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

/// Represents a cache of images
public protocol ImageCache: class { //class obliga a que este protocolo solo pueda ser implementado por clases
    
    /// Returns the image associated with a given URL
    func image(for url: URL) -> UIImage?
    
    /// Sets the image of the specified URL in the cache.
    func setImage(_ image: UIImage, for url: URL)
}

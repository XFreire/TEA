//
//  MemoryImageCache.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

/// A simple memory cache for images
final class MemoryImageCache: ImageCache {
    
    // NSCache is thread-safe
    // NSURL is used instead of URL as the key because
    // NSCache requires AnyObject, and URL is a value type
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

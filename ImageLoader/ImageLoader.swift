//
//  ImageLoader.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import RxSwift

/// Load images from URLs
public protocol ImageLoader {
    
    /// Loads an image from the specified URL.
    ///
    /// - parameter url: The URL.
    ///
    /// - returns: An observable that will send an image or nil, and then complete.
    func image(for url: URL) -> Observable<UIImage?>
}

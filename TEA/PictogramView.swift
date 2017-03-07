//
//  PictogramView.swift
//  TEA
//
//  Created by Alexandre Freire García on 7/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import ImageLoader
import RxSwift
import RxCocoa


/// Displays a pictogram image
class PictogramView: UIView {
    
    // MARK: Properties
    
    /// The url of the cover image
    var url: URL? {
        didSet {
            didSetURL()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    fileprivate let loader = RemoteImageLoader.instance
    fileprivate var disposeBag: DisposeBag?
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        
    }
}

// MARK: Private

private extension PictogramView {
    
    func setup() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func didSetURL() {
        // This will cancel any ongoing download
        self.disposeBag = nil
        imageView.image = nil
        
        guard let url = url else {
            return
        }
        
        let disposeBag = DisposeBag()
        
        // Load the image and bind the result to our observer property
        loader.image(for: url)
            .bindTo(imageObserver)
            .addDisposableTo(disposeBag)
        
        self.disposeBag = disposeBag
    }
    
    /// A bindable observer for remote images
    var imageObserver: AnyObserver<UIImage?> {
        
        return UIBindingObserver(UIElement: imageView) { imageView, image in
            
            // If there is an error (image is nil) we should cancel any ongoing
            // animations and reset our image view
            guard let image = image else {
                imageView.layer.removeAllAnimations()
                imageView.image = nil
                
                return
            }
            
            // Add a fade animation and set the image
            imageView.layer.add(CATransition.fade, forKey: kCATransition)
            imageView.image = image
            }.asObserver()
    }
}

private extension CATransition {
    
    static var fade: CATransition {
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        
        return transition
    }
}


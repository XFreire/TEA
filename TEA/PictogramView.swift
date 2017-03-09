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
    @IBOutlet weak var view: UIView!
    /// The url of the cover image
    var url: URL? {
        didSet {
            didSetURL()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    fileprivate let loader = RemoteImageLoader.instance
    fileprivate var disposeBag: DisposeBag?
    
    
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        fromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
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
            self.activityIndicator.stopAnimating()
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

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view 
    }
}


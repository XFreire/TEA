//
//  NameWithImageViewController.swift
//  TEA
//
//  Created by Alexandre Freire García on 11/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

class NameWithImageViewController: UIViewController {

    // MARK: - Views
    @IBOutlet weak var pictogramsGrid: GridView!
    @IBOutlet weak var namesGrid: GridView!
    
    // MARK: - Properties
    let viewModel: NameWithImageViewModel
    
    var pictogramViews = [PictogramView]()
    
    var pictogramNames = [UILabel]()
    
    var originalPosition: CGPoint?

    // MARK: - Initialization
    init(viewModel: NameWithImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Activities"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        edgesForExtendedLayout = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawExercise()
    }
    
    // MARK: - Actions
    func moveMe(rec:UIPanGestureRecognizer) {
        
        let translation = rec.translation(in: self.view)
        let view = rec.view!
        if originalPosition == nil {
            originalPosition = view.center
        }
        view.center = CGPoint(x: rec.view!.center.x + translation.x, y: rec.view!.center.y + translation.y)
        
        rec.setTranslation(CGPoint.zero, in: self.view)
        if rec.state == .ended {
            for i in 0..<pictogramViews.count {
                detectCollision(container: pictogramViews[i], view: view)
            }
            if originalPosition != nil {
                UIView.animate(withDuration: 0.5){
                    view.center = self.originalPosition!
                }
            }
        }
    }
    
    func detectCollision(container: UIView, view: UIView) {
        if (container.frame.intersects(view.frame)) {
            print("Collision!")
            let pictogramContainer = (container as? PictogramView)
            let nameLabel = (view as? UILabel)
            
            if pictogramContainer?.pictogram?.name.uppercased() == nameLabel?.text?.uppercased() {
                pictogramContainer?.titleLabel.text = nameLabel?.text
                
                UIView.animate(withDuration: 0.5, animations: {
                    view.center = container.center
                    (view as? UILabel)?.isHidden = true
                    container.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }, completion: { _ in
                    container.transform = CGAffineTransform.identity
                })
            } else {
                UIView.animate(withDuration: 0.5) {
                    guard let position = self.originalPosition else { return }
                    view.center = position
                    self.originalPosition = nil
                }
            }
            
        }
    }
    
    func drawExercise() {
        // 1. Pictogram Views
        pictogramViews = viewModel.pictograms.map {
            let pictogramView = PictogramView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 120)))
            //pictogramView.titleLabel.text = $0.name
            pictogramView.pictogram = $0
            pictogramView.url = $0.imageUrl
            return pictogramView
        }.shuffled

        // 2. Names
        pictogramNames = viewModel.pictograms.map {
            let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
            label.isUserInteractionEnabled = true
            label.text = $0.name.uppercased()
            label.textAlignment = .center
            label.borderColor = UIColor.gray
            label.borderWidth = 2
            
            label.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveMe(rec:))))
            
            return label
        }.shuffled
        
    
        
//        view.sendSubview(toBack: pictogramsGrid)
        // 3. Add subviews
        for pictogram in pictogramViews {
            //pictogramsGrid.firstColumn.addArrangedSubview(pictogram)
            let x = Int(view.width)/2 + Int(pictogramsGrid.width)/2
            let n = pictogramViews.count
            let h3 = Int(view.height)/n
            let h6 = Int(view.height)/(n*2)
            let index = pictogramViews.index(of: pictogram)! + 1
            let y = (h3 * index) - h6
            pictogram.center = CGPoint(x: x, y: y)
            view.addSubview(pictogram)
        }
        
        for label in pictogramNames {
            let x = Int(namesGrid.width)/2
            let n = pictogramViews.count
            let h3 = Int(view.height)/n
            let h6 = Int(view.height)/(n*2)
            let index = pictogramNames.index(of: label)! + 1
            let y = (h3 * index) - h6
            label.center = CGPoint(x: x, y: y)
            view.addSubview(label)
        }
    }

}

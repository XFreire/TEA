//
//  AddTaskViewController.swift
//  TEA
//
//  Created by Alexandre Freire García on 6/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import Container
import RxSwift

class AddPictogramsToTaskViewController: UIViewController {

    // MARK: - Views
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(PictogramCell.self)
            collectionView.backgroundColor = UIColor(named: .background)
        }
    }
    
    // MARK: - Properties
    
    var didFinish: () -> Void = {}
    
    /// Called when the user taps the microphone button
    var didTapMicrophone: () -> Void = { _ in }
    
    var didTapSave: ([Pictogram]) -> Void = { _ in }
    
    /// Called when the user selects a pictogram
    var didSelectPictogram: (Pictogram) -> Void = { _ in }
    
    fileprivate let viewModel: AddPictogramsToTaskViewModel
    
    fileprivate let disposeBag = DisposeBag()

    
    // MARK: - Initialization
    
    init(viewModel: AddPictogramsToTaskViewModel = AddPictogramsToTaskViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
//        titleTextField.rx.text.orEmpty
//            .subscribe(onNext: { [weak self] in
//                print("Text: \($0)")
//                self?.viewModel.taskTitle.value = $0
//            })
//            .addDisposableTo(disposeBag)
        
        
        
        titleTextField.rx.text.orEmpty
            .bindTo(viewModel.taskTitle)
            .addDisposableTo(disposeBag)
        
        viewModel.pictograms
            .bindTo(collectionView.rx.items(cellIdentifier: PictogramCell.defaultReuseIdentifier, cellType: PictogramCell.self)){ _, pictogramObs, cell in
                
                pictogramObs.subscribe(onNext: { pictogram in
                    cell.pictogramView.titleLabel.text = pictogram.name
                    cell.pictogramView.url = pictogram.imageUrl
                })
                .addDisposableTo(self.disposeBag)
            }
            .addDisposableTo(disposeBag)


        
        
    }
    
    // MARK: - Actions
    @IBAction func microphoneTapped(_ sender: Any) {
        didTapMicrophone()
    }
    
    func nextTapped() {

    }
    
    
    
}

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
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Font(.installed(.openSans), size: .standard(.h2)).instance
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.font = Font(.installed(.openSansLight), size: .standard(.h3)).instance
        }
    }
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.font = Font(.installed(.openSansLight), size: .standard(.h3)).instance
        }
    }
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var titleTextField: TextField!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(PictogramCell.self)
        }
    }
    
    // MARK: - Properties
    
    var didFinish: () -> Void = {}
    
    /// Called when the user taps the microphone button
    var didTapMicrophone: () -> Void = { _ in }
    
    var didTapNext: ([Pictogram]) -> Void = { _ in }
    
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
        navigationController!.navigationBar.shadowImage = nil
        self.edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
//        titleTextField.rx.text.orEmpty
//            .subscribe(onNext: { [weak self] in
//                print("Text: \($0)")
//                self?.viewModel.taskTitle.value = $0
//            })
//            .addDisposableTo(disposeBag)
        
//        titleTextField.rx.text.orEmpty
//            .bindTo(viewModel.query)
//            .addDisposableTo(disposeBag)
        
        titleTextField.textField.rx.text.orEmpty.subscribe(onNext: { [weak self] text in
            print(text)
            self?.viewModel.query.value = text
        }).addDisposableTo(disposeBag)
        
        
        viewModel.pictograms2
            .bindTo(collectionView.rx.items(cellIdentifier: PictogramCell.defaultReuseIdentifier, cellType: PictogramCell.self)){ _, pictogram, cell in
                cell.pictogramView.titleLabel.text = pictogram.name
                cell.pictogramView.url = pictogram.imageUrl
            }
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Actions
    @IBAction func microphoneTapped(_ sender: Any) {
        didTapMicrophone()
    }
    
    func nextTapped() {
        self.didTapNext(viewModel.pics)

    }
    
    
    
}

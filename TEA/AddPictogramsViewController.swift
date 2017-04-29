//
//  AddPictogramsViewController.swift
//  TEA
//
//  Created by Alexandre Freire García on 25/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import RxSwift
import Container

class AddPictogramsViewController: UIViewController {
    
    // MARK: - Views
    @IBOutlet weak var nameText: TextField!
    
    @IBOutlet weak var queryText: TextField!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PictogramCell.self)
        }
    }
    
    // MARK: - Properties
    let viewModel: AddPictogramsViewModel
    
    let disposeBag = DisposeBag()
    
    var didTapNext: ([Pictogram]) -> Void = { _ in }
    
    // MARK: - Initialization
    init(viewModel: AddPictogramsViewModel = AddPictogramsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Activities"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
        setupBindings()
    }
    
    // MARK: - Actions
    func nextTapped() {
        self.didTapNext(viewModel.pics)
    }
    
    // MARK: - Bindings
    func setupBindings() {
        
        queryText.textField.rx.text.orEmpty.subscribe(onNext: { [weak self] text in
            print(text)
            self?.viewModel.query.value = text
        }).addDisposableTo(disposeBag)
        
        
        
        viewModel.pictograms
            .bindTo(collectionView.rx.items(cellIdentifier: PictogramCell.defaultReuseIdentifier, cellType: PictogramCell.self)){ _, pictogram, cell in
                cell.pictogramView.titleLabel.text = pictogram.name
                cell.pictogramView.url = pictogram.imageUrl
            }
            .addDisposableTo(disposeBag)
        
        
    }
}

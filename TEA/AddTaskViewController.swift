//
//  AddTaskViewController.swift
//  TEA
//
//  Created by Alexandre Freire García on 15/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import Container
import RxSwift

class AddTaskViewController: UIViewController {

    // MARK: - Views
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PictogramCell.self)
        }
    }
    
    @IBOutlet weak var monday: DaySwich! {
        didSet {
            monday.day = .monday
            monday.style = .outline
            
        }
    }
    
    @IBOutlet weak var tuesday: DaySwich! {
        didSet {
            tuesday.day = .tuesday
        }
    }
    
    @IBOutlet weak var wednesday: DaySwich! {
        didSet {
            wednesday.day = .wednesday
        }
    }
    
    @IBOutlet weak var thursday: DaySwich! {
        didSet {
            thursday.day = .thursday
        }
    }
    
    @IBOutlet weak var friday: DaySwich! {
        didSet {
            friday.day = .friday
        }
    }
    
    @IBOutlet weak var saturday: DaySwich! {
        didSet {
            saturday.day = .saturday
        }
    }
    
    @IBOutlet weak var sunday: DaySwich! {
        didSet {
            sunday.day = .sunday
        }
    }
    
    // MARK: - Properties
    var daysOfWeek = Observable.just("")
    
    var didTapSave: () -> Void = { _ in }
    
    let viewModel: AddTaskViewModel
    
    let disposeBag = DisposeBag()
    // MARK: - Initialization
    init(viewModel: AddTaskViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))

    }
    
    convenience init(pictograms: [Pictogram]) {
        self.init(viewModel: AddTaskViewModel(pictograms: pictograms))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        titleTextField.textField.rx.text.orEmpty
            .bindTo(viewModel.name)
            .addDisposableTo(disposeBag)
        
        daysOfWeek = Observable
            .combineLatest(
                monday.isOn.asObservable(), tuesday.isOn.asObservable(), wednesday.isOn.asObservable(),
                thursday.isOn.asObservable(), friday.isOn.asObservable(), saturday.isOn.asObservable(),
                sunday.isOn.asObservable()) { mon, tue, wed, thu, fri, sat, sun in
                    
                    var days = ""
                    days = mon ? days+String(self.monday.day.rawValue)+"," : days+""
                    days = tue ? days+String(self.tuesday.day.rawValue)+"," : days+""
                    days = wed ? days+String(self.wednesday.day.rawValue)+"," : days+""
                    days = thu ? days+String(self.thursday.day.rawValue)+"," : days+""
                    days = fri ? days+String(self.friday.day.rawValue)+"," : days+""
                    days = sat ? days+String(self.saturday.day.rawValue)+"," : days+""
                    days = sun ? days+String(self.sunday.day.rawValue)+"," : days+""
                    
                    return days
        }
        
        daysOfWeek.bindTo(viewModel.daysQuery).addDisposableTo(disposeBag)
        
        Observable.just(viewModel.pictograms).bindTo(collectionView.rx.items(cellIdentifier: PictogramCell.defaultReuseIdentifier, cellType: PictogramCell.self)){ _, pictogram, cell in
            cell.pictogramView.titleLabel.text = pictogram.name
            cell.pictogramView.url = pictogram.imageUrl
        }.addDisposableTo(disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let index = indexPath.row
                self.viewModel.defaultImage.value = index
                print(index)
            }).addDisposableTo(disposeBag)
        
        viewModel.didSaveTask = { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)

        }

    }
    
    func saveTapped() {
        viewModel.didTapSave(titleTextField.text!)
    }
}

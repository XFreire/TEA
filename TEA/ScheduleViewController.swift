//
//  ScheduleViewController.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Container

class ScheduleViewController: UIViewController {
    
    // MARK: - Views
    @IBOutlet weak var mondayButton: UIButton! 
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PictogramCell.self)
        }
    }
    // MARK: - Properties
    var daysArray: [UIButton]?
    
    var didSelectAddTask: () -> Void = { _ in }
    
    let disposeBag = DisposeBag()
    
    let viewModel: ScheduleViewModelType
    
    // MARK: - Initialization
    init(viewModel: ScheduleViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Schedule"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        expandNavigationBar()
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysArray = [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton]
        
        edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskClicked))
        
        updateDayStyle(day: viewModel.day.value)
        
        viewModel.tasks
            .bindTo(collectionView.rx.items(cellIdentifier: PictogramCell.defaultReuseIdentifier, cellType: PictogramCell.self)){ _, task, cell in
                cell.pictogramView.titleLabel.text = task.name
                cell.pictogramView.url = task.coverUrl
            }
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Actions
    func addTaskClicked() {
        didSelectAddTask()
    }
    
    @IBAction func daySelected(_ sender: Any) {
        let day = DaysOfWeek(rawValue: (sender as AnyObject).tag)!
        viewModel.day.value = day
        updateDayStyle(day: day)
        
    }
    
    // MARK: - Other
    func updateDayStyle(day: DaysOfWeek){
        for button in daysArray! {
            if day.rawValue == button.tag {
                button.tintColor = UIColor.red
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
            } else {
                button.tintColor = UIColor(named: .darkText)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
            }
            
        }
    }
    
    func expandNavigationBar() {
        // Translucency of the navigation bar is disabled so that it matches with
        // the non-translucent background of the extension view.
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)
    }
    
}

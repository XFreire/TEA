//
//  AddTaskViewModel.swift
//  TEA
//
//  Created by Alexandre Freire García on 15/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import Container
import RxSwift

final class AddTaskViewModel {
    
    // MARK: - Properties
    let pictograms: [Pictogram]
    
    var name = Variable("")
    
    var daysQuery = Variable("")
    
    var defaultImage = Variable(0)
    
    private var days = [Int]()
    
    private let container: TaskContainerType
    
    var didTapSave: (_ name: String )-> Void = { _ in }
    
    var didSaveTask: () -> Void = { _ in }
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init(pictograms: [Pictogram], container: TaskContainerType = ModelContainer.instance) {
        
        self.container = container
        
        self.pictograms = pictograms
        
        let _ = daysQuery.asObservable()
            .subscribe(onNext: {
                self.days = $0.components(separatedBy: ",").flatMap{Int($0)}
                print(self.days)
            })
        
        didTapSave = { [weak self] name in
            guard let `self` = self else {
                return
            }
            
            let task = Task(name: name, daysOfWeek: self.days, pictograms: self.pictograms, imageIndex: self.defaultImage.value)
            
            self.container.save(tasks: [task])
                .observeOn(MainScheduler.instance)
                .subscribe(onError: {
                    print("Error: \($0)")
                }, onCompleted:{
                    self.didSaveTask()
                    print("Completed: \($0)")
                })
                .addDisposableTo(self.disposeBag)
        }
    }
    
    
    
}

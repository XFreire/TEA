//
//  ScheduleViewModel.swift
//  TEA
//
//  Created by Alexandre Freire García on 4/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import Container
import RxSwift
import Container
import SwifterSwift

protocol ScheduleViewModelType: class {
    
    var day: Variable<DaysOfWeek> { get set }
    
    var tasks: Observable<[Task]> { get }

    /// Called when volumes are inserted or removed
    var didUpdate: () -> Void { get set }
    
    /// The number of volumes in the list
    var numberOfTask: Int { get }
    
    /// Returns the volume at a given position
    func item(at position: Int) -> Task
    
}

final class ScheduleViewModel: ScheduleViewModelType {
    
    // MARK: - Properties
    var day: Variable<DaysOfWeek> = Variable(DaysOfWeek(rawValue: Date().weekday)!)
    
    private(set) lazy var tasks: Observable<[Task]> = self.day.asObservable()
        .flatMap{
            Observable.just(self.tasks(forDay: $0))
    }
    
    private func tasks(forDay day: DaysOfWeek) -> [Task] {
        return container.allTasks(forDay: day).all()
    }
    
    var didUpdate: () -> Void = {}
    
    var numberOfTask: Int {
        return results.numberOfTasks
    }
    
    func item(at position: Int) -> Task {
        return results.task(at: position)
    }
    
    private let container: TaskContainerType
    
    private let results: TaskResultsType
    
    // MARK: - Initialization
    init(container: TaskContainerType = ModelContainer.instance) {
        
        self.container = container
        
        self.results = container.allTasks(forDay: day.value)
        
        self.results.didUpdate = { [weak self] in
            self?.didUpdate()
        }
    }
}

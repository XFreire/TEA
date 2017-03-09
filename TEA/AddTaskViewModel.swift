//
//  AddTaskViewModel.swift
//  TEA
//
//  Created by Alexandre Freire García on 7/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import RxSwift
import Container
import TEAService

protocol AddTaskViewModelType {
    

    
    var taskTitle: Variable<String> { get }
    
    var pictograms: Observable<[Observable<Pictogram>]> { get }
    
}

final class AddTaskViewModel: AddTaskViewModelType {
    
    let taskTitle = Variable("")
    
    private(set) lazy var pictograms:  Observable<[Observable<Pictogram>]> = self.taskTitle.asObservable()
        .filter { query in
            query.characters.count > 3
        }
        .throttle(0.3, scheduler: MainScheduler.instance)
        .map{ query in
            query.components(separatedBy: " ").filter{ $0 != ""}
        }
        .map{ names in
            names.map{
                //Pictogram(identifier: UUID().uuidString, name: $0)
                self.client.searchPictogram(forQuery: $0)
                    .observeOn(MainScheduler.instance)
                    .shareReplay(1)
                }
            
        }
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    
    
    
    private let client: Client
    
    init(client: Client = Client()){
        self.client = client
    }

}

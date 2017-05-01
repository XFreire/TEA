//
//  AddPictogramsViewModel.swift
//  TEA
//
//  Created by Alexandre Freire García on 25/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import Container
import RxSwift
import TEAService

final class AddPictogramsViewModel {
    
    // MARK: - Properties
    let query = Variable("")
    
    var pics = [Pictogram]()
    
    let client: Client
    
    lazy var pictograms: Observable<[Pictogram]> = self.query.asObservable()
        .throttle(0.3, scheduler: MainScheduler.instance)
        .flatMapLatest{
            Observable.from($0.components(separatedBy: " ").filter{ $0 != "" })
        }
        .do(onNext: { _ in
            self.pics.removeAll()
        })
        .flatMap{
            self.client.searchPictogram(forQuery: $0)
                .catchError{ _ in return
                    Observable.of(Pictogram(name: "error"))
            }
        }
        .map{ pictogram in
            if pictogram.name != "error"{
                self.pics.append(pictogram)
            }
            return self.pics
        }
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    
    // MARK: - Initialization
    init(client: Client = Client()) {
        self.client = client
    }
  
}

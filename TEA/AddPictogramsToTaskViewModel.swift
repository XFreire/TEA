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

protocol AddPictogramsToTaskViewModelType {
    

    /// The pictogram query
    var query: Variable<String> { get }
    
    /// The current number of pictogram results
    var numberOfItems: Int { get }
    
    /// Returns the pictogram at a given position
    func item(at position: Int) -> Pictogram
    
    /// Called when pictograms are inserted or removed
    var didUpdate: () -> Void { get set }

}

final class AddPictogramsToTaskViewModel: AddPictogramsToTaskViewModelType {
    
    // MARK: - Properties
    private let client: Client
    private var container: PictogramContainerType
    private let results: PictogramResultsType
    private let disposeBag = DisposeBag()
    
    let query = Variable("")
    
    //private(set) lazy var pictograms: Observable<[Pictogram]> = self.container.a
    
    var numberOfItems: Int {
        return results.numberOfPictograms
    }
    
    func item(at position: Int) -> Pictogram {
        precondition(position < numberOfItems)
        return results.pictogram(at: position)
    }
    
    var didUpdate: () -> Void = {}
    
    private(set) lazy var pictograms: Observable<[Pictogram]> = self.query.asObservable()
        //.filter{ $0.characters.count > 3 }
        .throttle(0.3, scheduler: MainScheduler.instance)
        .flatMapLatest{ query in
            Observable.from(query.components(separatedBy: " ").filter{ $0 != "" })
        }
        .flatMap{
            self.client.searchPictogram(forQuery: $0).catchError{ _ in return
                Observable.of(Pictogram(name: "error"))
            }
        }
        .toArray()
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    
    var pics = [Pictogram]()
    
    private(set) lazy var pictograms2: Observable<[Pictogram]> = self.query.asObservable()
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
            print(pictogram.name)
            if pictogram.name != "error"{
                self.pics.append(pictogram)
            }
            return self.pics
        }
        .observeOn(MainScheduler.instance)
        .shareReplay(1)

    
    
    init(client: Client = Client(), container: PictogramContainerType = ModelContainer.temporary()){
        self.client = client
        self.container = container
                
        container.load()
            .subscribe()
            .addDisposableTo(disposeBag)
        
        
        
        results = container.allPictograms()
        
        results.didUpdate = { [weak self] _ in
            guard let `self` = self else { return }
            self.didUpdate()
        }
        
    }
    
    public func search() -> Observable<Void> {
        return doSearch()
    }
    
    private func doSearch() -> Observable<Void> {
        let container = self.container
        return self.query.asObservable()
            .filter{ $0.characters.count > 3 }
            .throttle(0.4, scheduler: MainScheduler.instance)
            .flatMap{
                Observable.from($0.components(separatedBy: " ").filter{ $0 != "" })
            }
            .flatMap{
                self.client.searchPictogram(forQuery: $0)
            }
            .flatMapLatest{ pictogram in
                container.save(pictograms: [pictogram])
            }
            .observeOn(MainScheduler.instance)
            .shareReplay(1)
    }
}

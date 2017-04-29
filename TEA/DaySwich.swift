//
//  DaySwich.swift
//  TEA
//
//  Created by Alexandre Freire García on 10/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import Container
import RxSwift
import RxCocoa

class DaySwich: UIButton {
    
    // MARK: - Properties
    enum Style {
        case outline, solid
    }

    var title: String {
        didSet {
            didSetTitle()
        }
    }
    
    var day: DaysOfWeek = .monday {
        didSet {
            didSetDay()
        }
    }
    var isOn: Variable<Bool> = Variable(false)
    
    var style: Style = .outline {
        didSet {
            didSetStyle()
        }
    }
    
    let disposeBag = DisposeBag()
    
    var isOnObserver: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: self) { button, isOn in
            button.style = isOn ? .solid : .outline
        }.asObserver()
    }
    
    // MARK: - Initialization
    init(title: String = "", style: Style = .outline) {
        self.title = title
        self.style = style
        
        super.init(frame: CGRect.zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = ""
        style = .outline
        
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        addTarget(self, action: #selector(swichSelection), for: .touchUpInside)
        layer.cornerRadius = height / 2
        isOn = Variable(false)
        style = .outline
        
        isOn.asObservable()
            .bindTo(isOnObserver)
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Actions
    func swichSelection() {
        isOn.value = !isOn.value
    }
    
    private func didSetTitle() {
        setTitle(title.uppercased(), for: .normal)
    }
    
    func didSetDay() {
        switch day{
        case .monday:
            setTitle("Monday", for: .normal)
        case .tuesday:
            setTitle("Tuesday", for: .normal)
        case .wednesday:
            setTitle("Wednesday", for: .normal)
        case .thursday:
            setTitle("Thursday", for: .normal)
        case .friday:
            setTitle("Friday", for: .normal)
        case .saturday:
            setTitle("Saturday", for: .normal)
        case .sunday:
            setTitle("Sunday", for: .normal)
        }
    }
    
    func didSetStyle() {
        clipsToBounds = true
        layer.borderWidth = 1.0
        if style == .outline {
            setupOutline()
            
        } else {
            setupSolid()
        }
        
        invalidateIntrinsicContentSize()
    }
    
    func setupOutline() {
        layer.borderColor = tintColor.cgColor
        setTitleColorForAllStates(tintColor)
        backgroundColor = UIColor.clear
    }
    
    func setupSolid() {
        borderColor = tintColor
        setTitleColorForAllStates(UIColor.white)
        backgroundColor = tintColor
    }
    
    
}

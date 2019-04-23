//
//  RegistrationViewModel.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 19/04/19.
//

import Foundation
import RxCocoa
import RxSwift

enum Pet: String, CustomStringConvertible, CaseIterable {
    case cat
    case dog
    case bird

    var description: String {
        return self.rawValue.prefix(1).capitalized + self.rawValue.dropFirst()
    }
}

class RegistrationViewModel {
    var name: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var email: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var favoritePet: BehaviorRelay<Pet?> = BehaviorRelay(value: nil)

    lazy var isNameValid: Observable<Bool> = {
        name.map { name in
            guard let name = name else { return false }
            guard name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 2 else { return false }
            return true
        }
    }()

    lazy var isEmailValid: Observable<Bool> = {
        email.map { email in
            guard let email = email else { return false }
            guard email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 2 else { return false }
            guard email.contains("@") else { return false }
            guard email.contains(".") else { return false }
            return true
        }
    }()

    lazy var isPetValid: Observable<Bool> = favoritePet.map { $0 != nil }

    lazy var isValid: Observable<Bool> = {
        Observable.combineLatest(isNameValid, isEmailValid, isPetValid)
            .map { isNameValid, isEmailValid, isPetValid in
                isNameValid &&
                    isEmailValid &&
                    isPetValid
            }
    }()
}

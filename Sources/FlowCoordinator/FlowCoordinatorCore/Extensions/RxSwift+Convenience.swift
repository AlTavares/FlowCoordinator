//
//  RxSwift+Convenience.swift
//  BreatheCore
//
//  Created by Alexandre Mantovani Tavares on 08/02/19.
//

import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt

public extension Observable {
    func subscribeNext(_ onNext: ((Element) -> Void)?) -> Disposable {
        return subscribe(onNext: onNext)
    }

    func ensure(_ ensure: @escaping (() -> Void)) -> Observable<Element> {
        return self.do(
            onNext: { _ in
                ensure()
            }, onError: { _ in
                ensure()
        }, onCompleted: ensure)
    }
}

public extension PrimitiveSequenceType where TraitType == CompletableTrait, ElementType == Never {
    func subscribeCompleted(_ onCompleted: (() -> Void)?) -> Disposable {
        return subscribe(onCompleted: onCompleted)
    }
}

public extension ObservableType where Self.E == Void {
    func withUnretained<T: AnyObject>(_ obj: T) -> Observable<T> {
        return self.withUnretained(obj) { $0.0 }
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy {
    func driveNext(_ onNext: ((Element) -> Void)?) -> Disposable {
        return drive(onNext: onNext)
    }
}

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return self.map { _ in () }
    }
}

public extension BehaviorRelay where Element: Equatable {
    /// Accepts `event` if distinct and emits it to subscribers
    func acceptDistinct(_ event: Element) {
        guard event != self.value else { return }
        self.accept(event)
    }
}

public extension Disposable {
    /// use this instead of _ = for clarity
    /// it's useful for Singles and Completables
    func ignoreDisposable() {}
}

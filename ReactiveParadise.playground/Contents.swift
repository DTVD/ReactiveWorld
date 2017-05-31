//: Playground - noun: a place where people can play

import UIKit
import RxSwift

let originalObservable = Observable.from([1,2,3,4,5,6,7,8,9,10])

let defaultValueAfter5seconds = Observable<Int>.interval(5, scheduler: SerialDispatchQueueScheduler(qos: .background))
    .map{_ in "defaultValue"}


let observableWithDefaultValue = originalObservable.flatMapLatest{ item in
    return Observable.just(item).concat(defaultValueAfter5seconds)
}

let initialObservable = defaultValueAfter5seconds.takeUntil(originalObservable)
let finalObservable = Observable.merge(initialObservable, observableWithDefaultValue)



let d = originalObservable.flatMapLatest{ item in
    return Observable<Int>.interval(5, scheduler: SerialDispatchQueueScheduler(qos: .background))
        .map{_ in "defaultValue"}
}

let f =  Observable.merge(originalObservable, d, initialObservable)

defaultValueAfter5seconds
    .debug()
    .subscribe()

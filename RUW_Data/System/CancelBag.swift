//
//  CancelBag.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 22.07.2022.
//

import Combine

final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.removeAll()
    }

    func cancel(subscription: AnyCancellable) {
        subscriptions.remove(subscription)
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}


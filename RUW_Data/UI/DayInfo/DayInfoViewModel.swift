//
//  DayInfoViewModel.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 24.07.2022.
//

import Combine
import SwiftUI

class DayInfoViewModel: DayInfoViewModelType {

    // MARK: - Services
    private let cancelBag = CancelBag()

    let routing = Routing()

    // MARK: - Routing
    struct Routing {
        var close = PassthroughSubject<Void, Never>()
    }

    var dayInfo: Losses

    // MARK: - Intialization
    init(dayInfo: Losses) {
        self.dayInfo = dayInfo
    }
}

// MARK: - Routing Actions
extension DayInfoViewModel {
    func close() {
        self.routing.close.send()
    }
}

// MARK: - View model protocol
protocol DayInfoViewModelType: ObservableObject {
    // Routing Actions
    func close()

    // Outputs
    var dayInfo: Losses { get }
}

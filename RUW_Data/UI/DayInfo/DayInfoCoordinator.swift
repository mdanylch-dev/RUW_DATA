//
//  DayInfoCoordinator.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 24.07.2022.
//

import UIKit
import Combine
import SwiftUI

class DayInfoCoordinator: Coordinator<Void> {
    private let router: Router!
    private let viewModel: DayInfoViewModel
    
    init(router: Router, dayInfo: Losses) {
        self.router = router
        self.viewModel = DayInfoViewModel(dayInfo: dayInfo)
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewController = UIHostingController(rootView: DayInfoView(viewModel: viewModel))
        presentedViewController = viewController
        
        router.push(viewController, isAnimated: true) { [weak viewModel] in
            viewModel?.routing.close.send(())
        }
        
        return viewModel.routing.close
            .handleEvents(receiveOutput: { [weak router, weak viewController] _ in
                guard let viewController = viewController else { return }
                router?.pop(viewController, true)
            })
            .eraseToAnyPublisher()
    }
}

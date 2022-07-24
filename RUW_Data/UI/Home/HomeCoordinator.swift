//
//  HomeCoordinator.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 22.07.2022.
//

import Combine
import SwiftUI

class HomeCoordinator: Coordinator<Void> {

    private let window: UIWindow
    private var router: Router!

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = HomeViewModel()
        let viewController = UIHostingController(rootView: HomeView(viewModel: viewModel))
        presentedViewController = viewController

        router = Router(navigationController: UINavigationController(rootViewController: viewController))
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()

        viewModel.routing.goToDetails
            .flatMap { [weak self, weak router] dayInfo -> AnyPublisher<Void, Never> in
                guard let self = self, let router = router else { return Empty(completeImmediately: true).eraseToAnyPublisher() }
                return self.coordinate(to: DayInfoCoordinator(router: router, dayInfo: dayInfo))
            }
            .sink(receiveValue: { })
            .store(in: cancelBag)

        return Empty<Void, Never>(completeImmediately: false)
            .eraseToAnyPublisher()
    }
}

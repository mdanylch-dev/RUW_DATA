//
//  HomeViewModel.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 22.07.2022.
//

import Foundation
import Combine

class HomeViewModel: HomeViewModelType {

    private let cancelBag = CancelBag()
    private let networkService = NetworkService()
    private var losses: Losses?

    // MARK: - Routing
    struct Routing {
        var goToDetails = PassthroughSubject<Losses, Never>()
    }

    // MARK: - Bindings
    @Published private(set) var equipment: [EquipmentModel] = []
    @Published private(set) var personnel: [PersonnelModel] = []

    let routing = Routing()


    // MARK: - Actions
    func goToDetails(dayEquipment: EquipmentModel) {
        if let dayPersonel = personnel.first(where: {$0.date == dayEquipment.date}) {
            routing.goToDetails.send(Losses(equipment: dayEquipment, personnel: dayPersonel))
        }

    }

    struct CoordinatorInput {
        var goToSecondView: AnyPublisher<Void, Never>
    }

    // MARK: - Intialization
    init() {
        fetchDataEquipment()
        fetchDataPersennel()
    }

    private func fetchDataEquipment() {
        networkService.fetchEquipmentData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            }, receiveValue: { [weak self] equipmentArray in
                guard let self = self else { return }
                self.equipment = equipmentArray
            })
            .store(in: self.cancelBag)
    }

    private func fetchDataPersennel() {
        networkService.fetchPersonnelData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            }, receiveValue: { [weak self] personnelArray in
                guard let self = self else { return }
                self.personnel = personnelArray
            })
            .store(in: self.cancelBag)
    }
}

// MARK: - View model protocol
protocol HomeViewModelType: ObservableObject {
    // Inputs
    func goToDetails(dayEquipment: EquipmentModel)

    // Outputs
    var equipment: [EquipmentModel] { get }
    var personnel: [PersonnelModel] { get }
}

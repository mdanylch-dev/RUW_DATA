//
//  NetworkService.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 23.07.2022.
//

import Foundation
import Combine

struct NetworkService {
    private let cancelBag = CancelBag()

    private let urlStringEquipment = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
    private let urlStringPeople = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"

    func fetchEquipmentData() -> AnyPublisher<[EquipmentModel], Error> {
        let url = URL(string: urlStringEquipment)!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [EquipmentModel].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }


    func fetchPersonnelData() -> AnyPublisher<[PersonnelModel], Error> {
        let url = URL(string: urlStringPeople)!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PersonnelModel].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}



//
//  PersonnelModel.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 24.07.2022.
//

import Foundation

struct PersonnelModel: Decodable, Identifiable {
    let id: UUID
    let date: String
    let day: String
    let personnel: Int
    let personnelInfo: String
    let prisonerOfWar: Int

    private enum CodingKeys: String, CodingKey {
        case date, day, personnel, personnelInfo = "personnel*", prisonerOfWar = "POW"
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        date = try container.decode(String.self, forKey: .date)
        day = try String(container.decode(Int.self, forKey: .day))
        personnel = try container.decode(Int.self, forKey: .personnel)
        personnelInfo = try container.decode(String.self, forKey: .personnelInfo)
        prisonerOfWar = (try? container.decode(Int.self, forKey: .prisonerOfWar)) ?? 0
    }
}

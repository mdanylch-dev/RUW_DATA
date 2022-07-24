//
//  EquipmentModel.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 24.07.2022.
//

import Foundation

struct EquipmentModel: Decodable, Identifiable {
    let id: UUID
    let date: String
    let day: String
    let aircraft: Int
    let helicopter: Int
    let tank: Int
    let armoredPersonnelCarrier: Int
    let fieldArtillery: Int
    let multipleRocketLauncher: Int
    let militaryAuto: Int
    let fuelTank: Int
    let drone: Int
    let navalShip: Int
    let antiAircraftWarfare: Int
    let specialEquipment: Int?
    let mobileSrbmSystem: Int?
    let vehiclesAndFuelTanks: Int?
    let cruiseMissiles: Int?
    let greatestLossesDirection: String


    private enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank, armoredPersonnelCarrier = "APC", fieldArtillery = "field artillery", multipleRocketLauncher = "MRL", militaryAuto = "military auto", fuelTank = "fuel tank", drone, navalShip = "naval ship", antiAircraftWarfare = "anti-aircraft warfare", specialEquipment = "special equipment", mobileSrbmSystem = "mobile SRBM system", vehiclesAndFuelTanks = "vehicles and fuel tanks", cruiseMissiles = "cruise missiles", greatestLossesDirection = "greatest losses direction"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        date = try container.decode(String.self, forKey: .date)
        do {
            day = try String(container.decode(Int.self, forKey: .day))
        } catch DecodingError.typeMismatch {
            day = try container.decode(String.self, forKey: .day)
        }
        aircraft = try container.decode(Int.self, forKey: .aircraft)
        helicopter = try container.decode(Int.self, forKey: .helicopter)
        tank = try container.decode(Int.self, forKey: .tank)
        armoredPersonnelCarrier = try container.decode(Int.self, forKey: .armoredPersonnelCarrier)
        fieldArtillery = try container.decode(Int.self, forKey: .fieldArtillery)
        multipleRocketLauncher = try container.decode(Int.self, forKey: .multipleRocketLauncher)
        militaryAuto = (try? container.decode(Int.self, forKey: .militaryAuto)) ?? 0
        fuelTank = (try? container.decode(Int.self, forKey: .fuelTank)) ?? 0
        drone = try container.decode(Int.self, forKey: .drone)
        navalShip = try container.decode(Int.self, forKey: .navalShip)
        antiAircraftWarfare = try container.decode(Int.self, forKey: .antiAircraftWarfare)
        specialEquipment = (try? container.decode(Int.self, forKey: .specialEquipment)) ?? 0
        mobileSrbmSystem = (try? container.decode(Int.self, forKey: .mobileSrbmSystem)) ?? 0
        vehiclesAndFuelTanks = (try? container.decode(Int.self, forKey: .vehiclesAndFuelTanks)) ?? 0
        cruiseMissiles = (try? container.decode(Int.self, forKey: .cruiseMissiles)) ?? 0
        greatestLossesDirection = (try? container.decode(String.self, forKey: .greatestLossesDirection)) ?? ""
    }
}

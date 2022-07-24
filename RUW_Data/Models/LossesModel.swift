//
//  LossesModel.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 24.07.2022.
//

import Foundation

struct Losses: Decodable {
    var equipment: EquipmentModel
    var personnel: PersonnelModel
}

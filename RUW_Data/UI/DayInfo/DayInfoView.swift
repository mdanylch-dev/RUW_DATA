//
//  DayInfoView.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 24.07.2022.
//

import SwiftUI
import Combine

struct DayInfoView<VM>: View where VM: DayInfoViewModelType {
    @ObservedObject var viewModel: VM

    var body: some View {
        ZStack {
            self.content
        }
    }

    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Text("On \(self.viewModel.dayInfo.personnel.day) Day of russia-Ukrainian war \(self.viewModel.dayInfo.personnel.personnelInfo)\(self.viewModel.dayInfo.personnel.personnelInfo == "more" ? " than " : " ")\(self.viewModel.dayInfo.personnel.personnel) invaders was eliminated")
                    .font(.headline)
                    .padding(.bottom, 16)
                Text("russian Equipment Losses:")
                    .font(.title )
                    .frame(alignment: .center)
                cell(title: "Aircrafts", amount: "\(self.viewModel.dayInfo.equipment.aircraft)")
                cell(title: "Helicopters", amount: "\(self.viewModel.dayInfo.equipment.helicopter)")
                cell(title: "Tanks", amount: "\(self.viewModel.dayInfo.equipment.tank)")
                cell(title: "Armored personnel carrier", amount: "\(self.viewModel.dayInfo.equipment.armoredPersonnelCarrier)")
                cell(title: "Field artillery", amount: "\(self.viewModel.dayInfo.equipment.fieldArtillery)")
                cell(title: "Multiple rocket launchers", amount: "\(self.viewModel.dayInfo.equipment.multipleRocketLauncher)")
                Group {
                    if let vehiclesAndFuelTanks = self.viewModel.dayInfo.equipment.vehiclesAndFuelTanks, vehiclesAndFuelTanks > 0 {
                        cell(title: "Vehicles and fuel tanks", amount: "\(vehiclesAndFuelTanks)")
                    } else {
                        cell(title: "Military auto", amount: "\(self.viewModel.dayInfo.equipment.militaryAuto)")
                        cell(title: "Fuel tanks", amount: "\(self.viewModel.dayInfo.equipment.fuelTank)")
                    }
                    cell(title: "Drones", amount: "\(self.viewModel.dayInfo.equipment.drone)")
                    cell(title: "Naval ships", amount: "\(self.viewModel.dayInfo.equipment.navalShip)")
                    cell(title: "Anti aircraft warfare", amount: "\(self.viewModel.dayInfo.equipment.antiAircraftWarfare)")
                    if let value = self.viewModel.dayInfo.equipment.specialEquipment, value > 0 {
                        cell(title: "Special equipment", amount: "\(value)")
                    }
                    if let value = self.viewModel.dayInfo.equipment.mobileSrbmSystem, value > 0 {
                        cell(title: "Mobile SRBM Systems", amount: "\(value)")
                    }
                    if let value = self.viewModel.dayInfo.equipment.cruiseMissiles, value > 0 {
                        cell(title: "Cruise missiles", amount: "\(value)")
                    }
                    if !self.viewModel.dayInfo.equipment.greatestLossesDirection.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Greatest losses direction(s):")
                                .font(.headline)
                            Text(self.viewModel.dayInfo.equipment.greatestLossesDirection)
                                .font(.system(size: 17, weight: .light, design: .rounded))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)

        }
    }

    private func cell(title: String, amount: String) -> some View {
        HStack(spacing: 16) {
            Text(title)
                .font(.headline)
            Text(amount)
                .font(.system(size: 17, weight: .light, design: .rounded))
        }
    }
}

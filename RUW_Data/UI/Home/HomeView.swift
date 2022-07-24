//
//  HomeView.swift
//  RUW_Data
//
//  Created by Nikita Danylchenko on 22.07.2022.
//

import SwiftUI

struct HomeView<VM>: View where VM: HomeViewModelType {
    @ObservedObject var viewModel: VM

    var body: some View {
        ZStack(alignment: .top) {
            mainInfo
            .navigationBarHidden(true)
        }
    }

    private var mainInfo: some View {
        List {
            ForEach(self.viewModel.equipment) { equipment in
                VStack(alignment: .leading, spacing: 5) {
                    HStack() {
                        Text("\(equipment.day) day")
                        Spacer()
                        Text("\(equipment.date)")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.viewModel.goToDetails(dayEquipment: equipment)
                }
            }
        }
    }
}

// MARK: - Preview
#if DEBUG

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

#endif

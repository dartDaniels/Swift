//
//  SecondView.swift
//  LabTask
//
//  Created by Данила Казмирук on 26.04.2024.
//

import SwiftUI

struct SecondView: View {
    @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
        NavigationView {
            HStack {
                    VStack {
                            Text("Choose system")
                            Picker(selection: $forecastListVM.system, label: Text("System")) {
                                Text("°C").tag(0)
                                Text("°F").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 150)
                            .padding(.horizontal)
                            Spacer()
                    } 
                    .font(.title2)
                    .padding(.vertical)
                    .navigationTitle("Settings").navigationBarTitleDisplayMode(.inline)
                }
                
                    
                
            }
        }
    }

#Preview {
    SecondView()
}

//
//  TestingTab.swift
//  LabTask
//
//  Created by Данила Казмирук on 26.04.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
            TabView() {
                FirstView().tabItem
                { Text("Forecast"); 
                    Image(systemName: "chart.bar.xaxis")}.tag(0)
                SecondView().tabItem
                { Text("Settings");
                    Image(systemName: "gear")}.tag(1)
            }
        
    }
}
#Preview {
    ContentView()
}

//
//  FirstView.swift
//  LabTask
//
//  Created by Данила Казмирук on 26.04.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct FirstView: View {
    @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
        ZStack {
                NavigationView {
                    VStack {
                        HStack {
                            TextField("Enter location", text: $forecastListVM.location)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay (
                                    Button(action: {
                                        forecastListVM.location = ""
                                        forecastListVM.getWeatherForecast()
                                    }) {
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(.gray)
                                    }
                                        .padding(.horizontal),
                                    alignment: .trailing
                                    
                                )
                            Button {
                                forecastListVM.getWeatherForecast()
                            } label: {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .font(.title3)
                            }
                        }
                        
                        
                        List(forecastListVM.forecasts, id: \.day)  { day in
                                VStack(alignment: .leading) {
                                    Text (day.day)
                                        .fontWeight(.bold)
                                    HStack(alignment: .center) {
                                        WebImage(url: day.weatherIconURL)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 75)

                                        VStack(alignment: .leading) {
                                            Text(day.overview)
                                                .font(.title2)
                                            HStack(alignment: .center)
                                            {
                                                Text(day.current).font(.title2)
                                            }
                                            HStack() {
                                                Text(day.high)
                                                Text(day.low)
                                            }
                                            HStack() {
                                                Text(day.humidity)
                                                Text(day.pop)
                                            }
                                        }
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                    }
                    .padding(.horizontal)
                    .navigationTitle("Forecast")
                    .navigationBarTitleDisplayMode(.inline)
                    .alert(item: $forecastListVM.appError) { appAlert in
                        Alert(title: Text("Error"),
                            message: Text("""
                                    \(appAlert.errorString)
                                    Please, try again later
                                    """
                                    )
                              )
                    }
                }
            
                if forecastListVM.isLoading {
                    ZStack {
                        Color(.white)
                            .opacity(0.3)
                            .ignoresSafeArea()
                        ProgressView("Loading a weather")
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.systemBackground))
                            )
                            .shadow(radius: 15)
                }
            }
        }
    }
}



#Preview {
    FirstView()
}

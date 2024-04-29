//
//  ForecastListViewModel.swift
//  LabTask
//
//  Created by Данила Казмирук on 23.04.2024.
//
import CoreLocation
import Foundation
import SwiftUI

class ForecastListViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var forecasts: [ForecastViewModel] = []
    var appError: AppError? = nil
    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation: String = ""
    @Published var location = ""
    @AppStorage("system") var system: Int = 0 {
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].system = system
            }
        }
    }
    
    init() {
        location = storageLocation
        getWeatherForecast()
    }
    
    func getWeatherForecast() {
        storageLocation = location
        if location == "" {
            forecasts = []
        } else {
            isLoading = true
            let apiService = APIServises.shared
            CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                if let error = error {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                    print(error.localizedDescription)
                }
                if let lat = placemarks?.first?.location?.coordinate.latitude,
                   let lon = placemarks?.first?.location?.coordinate.longitude {
                    apiService.getJSON(urlString:"https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=0ef9e2261172d3d163f43e9053f0946b",
                                       dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIServises.APIError>) in
                        switch result {
                        case.success(let forecast):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.forecasts = forecast.list.map {ForecastViewModel(forecast: $0, system: self.system)}
                            }
                        case.failure(let apiError):
                            switch apiError {
                            case.error(let errorString):
                                self.isLoading = false
                                self.appError = AppError(errorString: errorString)
                                print(errorString)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

//
//  ForecastViewModel.swift
//  LabTask
//
//  Created by Данила Казмирук on 22.04.2024.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.list
    var system: Int
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    func convert( temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    var day: String {
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var high: String {
        return "High: \(Self.numberFormatter.string(for: convert(temp: forecast.main.temp_max)) ?? "0")°"
    }
    
    var low: String {
        return "Low: \(Self.numberFormatter.string(for: convert(temp: forecast.main.temp_min)) ?? "0")°"
    }
    
    var current: String {
        return "Right now: \(Self.numberFormatter.string(for: convert(temp: forecast.main.temp)) ?? "0")°"
    }
    
    var pop: String {
        return "☔️ \(Self.numberFormatter2.string(for: forecast.pop) ?? "0%")"
    }
    
    var humidity: String {
        return "Humidity: \(forecast.main.humidity)%"
    }
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }

}

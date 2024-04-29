//
//  Forecast.swift
//  LabTask
//
//  Created by Данила Казмирук on 21.04.2024.
//

import Foundation
struct Forecast: Codable {
    struct list: Codable {
        let dt: Date
        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let humidity: Int
        }
        let main: Main
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
        }
        let weather: [Weather]
        let pop: Double
    }
    let list: [list]
    
}

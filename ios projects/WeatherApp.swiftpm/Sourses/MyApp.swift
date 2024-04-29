import SwiftUI
import CoreLocation

struct Forecast: Codable {
    struct list: Codable {
        let dt: Date
        struct Main: Codable {
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


let apiService = APIServises.shared
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "E, MMM, d"
CLGeocoder().geocodeAddressString("Omsk") { (placemarks, error) in
    if let error = error {
        print(error.localizedDescription)
    }
    if let lat = placemarks?.first?.location?.coordinate.latitude,
       let lon = placemarks?.first?.location?.coordinate.longitude {
        apiService.getJSON(urlString: "api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=0ef9e2261172d3d163f43e9053f0946b",
                           dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIServises.APIError>) in
            switch result {
            case .success(let forecast):
                for day in forecast.list {
                    print(dateFormatter.string(from: day.dt))
                    print("   Max: ", day.main.temp_max)
                    print("   Min: ", day.main.temp_min)
                    print("   Humidity", day.main.humidity)
                    print("   Description", day.weather[0].description)
                    print("   pop", day.pop)

                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
                                                                                                        
        }
    }
}



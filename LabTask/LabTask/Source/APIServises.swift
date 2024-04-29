import Foundation

// public class OpenWeatherMapAPIService
public class APIServises {
    public static let shared = APIServises()
    // private let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=0ef9e2261172d3d163f43e9053f0946b",
    
    public enum APIError: Error {
        case error(errorString: String)
    }
    // public func getWeatherData(lat: String, lon: String)
    
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping(Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(errorString:NSLocalizedString("Error: Invalid URL", comment: "") )))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            if let error = error {
                completion(.failure(.error(errorString: "Error: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(errorString:NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error(errorString: "Error: \(decodingError.localizedDescription)")))
                return
            }
            
            
        }.resume()
    }
}

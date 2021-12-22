//
//  WeatherManager.swift
//  KiniCuaca
//
//  Created by Benjamin Purbowasito on 22/12/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailedWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3646377821c4b09b57246b615839c0c2&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    // CREATE URL SESSION FOR NETWORKING STEPS
    
    func performRequest(with urlString: String) {
        
        // 1. CREATE URL
        
        if let url = URL(string: urlString) {
            
            // 2. CREATE URL SESSION
            
            let session = URLSession(configuration: .default)
            
            // 3. GIVE A SESSION A TASK
            
            // let task = session.dataTask(with: url, completionHandler: handle(data:respon:error:))
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailedWithError(error: error! )
                    return
                }
                
                if let safeData = data {
                    
                    // to get whole JSON data from OpenWeather API
                    
                    // let stringData = String(data: safeData, encoding: .utf8)
                    // print(stringData)
                    
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. START TASK
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = (decodedData.weather[0].id)
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            print(weather.conditionName)
            print(weather.tempString)
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
        }
    }
}

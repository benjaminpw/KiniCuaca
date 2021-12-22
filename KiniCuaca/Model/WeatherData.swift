//
//  WeatherData.swift
//  KiniCuaca
//
//  Created by Benjamin Purbowasito on 22/12/21.
//

import Foundation


struct WeatherData: Codable {
    
    let name: String
    let timezone: Int
    let main: Main
    
    // property weather pada JSON OpenWeather berupa array sehingga tipe data menjadi [tipedata]
    let weather: [Weather]
}

struct Main: Codable {
    
    let temp: Double
}

struct Weather: Codable {
    
    let description: String
    let id: Int
}

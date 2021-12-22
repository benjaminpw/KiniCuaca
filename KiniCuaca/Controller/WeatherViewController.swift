//
//  WeatherViewController.swift
//  KiniCuaca
//
//  Created by Benjamin Purbowasito on 22/12/21.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet var searchTextField: UITextField!
    @IBAction func updateCurrentLocation(_ sender: Any) {
        
        locationManager.requestLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}


extension WeatherViewController: UITextFieldDelegate {
    
    
    
}

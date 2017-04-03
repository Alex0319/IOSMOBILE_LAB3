//
//  ViewController.swift
//  WeatherWatch
//
//  Created by Admin on 25.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import GoogleMaps

class WeatherViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapViewWeather: GMSMapView!
    var weatherInfo: WeatherInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: (weatherInfo?.latitude)!, longitude: (weatherInfo?.longitude)!, zoom: 9)
        mapViewWeather.camera = camera
        MarkerFactory.addLocationMarker(mapViewWeather: mapViewWeather, weatherInfo: weatherInfo)
        mapViewWeather.settings.scrollGestures = false
        mapViewWeather.settings.zoomGestures = false
        mapViewWeather.settings.rotateGestures = false
        mapViewWeather.settings.tiltGestures = false
        mapViewWeather.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mapViewWeather.clear()
    }
}


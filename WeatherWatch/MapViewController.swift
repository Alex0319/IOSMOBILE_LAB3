//
//  MapViewController.swift
//  WeatherWatch
//
//  Created by Admin on 02.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var weatherController:WeatherController? = nil

    override func viewDidLoad(){
        super.viewDidLoad()
        let mainTabBarController = self.tabBarController as! MainTabBarViewController
        weatherController = mainTabBarController.weatherController
        addAllMarkers()
        mapView.delegate = self
        mapView.settings.zoomGestures = false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let foundWeatherInfoPlace = CalculateDistancesService.getCloserPlace(weatherController: weatherController!, currentCoordinate: coordinate)
        mapView.camera = GMSCameraPosition.camera(withLatitude: foundWeatherInfoPlace.latitude, longitude: foundWeatherInfoPlace.longitude, zoom: 6)
    }
    
    private func addAllMarkers(){
        for i in 0 ..< (weatherController?.getCountOfWeatherRecords())!{
            let currentWeatherInfo: WeatherInfo = (weatherController?.getCityWeatherInfo(index: i))!
            MarkerFactory.addLocationMarker(mapViewWeather: mapView, weatherInfo: currentWeatherInfo)
        }	
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.camera = GMSCameraPosition.camera(withLatitude: 48.742, longitude: 18.9197, zoom: 4)
    }
}

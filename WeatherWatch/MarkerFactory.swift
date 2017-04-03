//
//  MarkerFactory.swift
//  WeatherWatch
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import GoogleMaps

class MarkerFactory{
    
    public static func addLocationMarker(mapViewWeather: GMSMapView,weatherInfo: WeatherInfo?){
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: (weatherInfo?.latitude)!, longitude: (weatherInfo?.longitude)!))
        marker.title = weatherInfo?.cityName
        marker.snippet = weatherInfo?.getWeatherInfoString()
        marker.opacity = 0.6
        marker.map = mapViewWeather
    }
}

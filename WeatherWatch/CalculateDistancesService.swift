//
//  CalculateDistancesService.swift
//  WeatherWatch
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import MapKit

class CalculateDistancesService{
    private static func calculateDistance(firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> Int{
        let firstLocation = CLLocation(latitude: firstCoordinate.latitude, longitude: firstCoordinate.longitude)
        let secondLocation = CLLocation(latitude: secondCoordinate.latitude, longitude: secondCoordinate.longitude)
        return Int(firstLocation.distance(from: secondLocation))
    }
    
    public static func getCloserPlace(weatherController: WeatherController, currentCoordinate: CLLocationCoordinate2D) -> WeatherInfo{
        var resultWeatherInfoIndex: Int = 0
        var minDistance: Int = 0
        for i in 0 ..< weatherController.getCountOfWeatherRecords(){
            let currentWeatherInfo: WeatherInfo = weatherController.getCityWeatherInfo(index: i)
            let currentDistance = calculateDistance(firstCoordinate: CLLocationCoordinate2D(latitude: currentWeatherInfo.latitude,longitude: currentWeatherInfo.longitude), secondCoordinate: currentCoordinate)
            if minDistance == 0 {
                minDistance = currentDistance
            }else{
                if(minDistance > currentDistance){
                    minDistance = currentDistance
                    resultWeatherInfoIndex = i
                }
            }
        }
        return weatherController.getCityWeatherInfo(index: resultWeatherInfoIndex)
    }
}

//
//  WeatherInfo.swift
//  WeatherWatch
//
//  Created by Admin on 31.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//
struct WeatherInfo{
    let cityTemperature:String
    let latitude:Double
    let longitude:Double
    let pressure:Int
    let humidity:Int
    let windSpeed:Double
    let cityName: String?
    let description: String
    
    init(name:String, latitude:Double, longitude:Double, temperature:Int, pressure:Int, humidity:Int, windSpeed:Double, description: String){
        self.cityName = name
        self.latitude = latitude
        self.longitude = longitude
        if temperature > 0{
            self.cityTemperature = "+"+String(temperature)+" C˚"
        }else{
            self.cityTemperature = String(temperature)+" C˚"
        }
        self.pressure = pressure
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.description = description
    }
    
    public func getWeatherInfoString() -> String{
        return String("\(self.cityTemperature) \(self.description)\nАтмосферное давление: \(Double(self.pressure) * 0.75) мм.рт.ст.\nВлажность: \(self.humidity) %\nСкорость ветра: \(self.windSpeed) м/c")
    }
}

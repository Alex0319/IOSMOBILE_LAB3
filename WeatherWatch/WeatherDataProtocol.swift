//
//  WeatherDataProtocol.swift
//  WeatherWatch
//
//  Created by Admin on 31.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

protocol WeatherDataProtocol {
    func reloadAfter()
    func showError(errorString: String)
}

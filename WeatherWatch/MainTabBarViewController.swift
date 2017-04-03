//
//  MainTabBarViewController.swift
//  WeatherWatch
//
//  Created by Admin on 02.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var weatherController:WeatherController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherController = WeatherController()
    }
}

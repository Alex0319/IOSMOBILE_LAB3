//
//  TableViewController.swift
//  WeatherWatch
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if(segue.identifier == "ShowWeatherTable"){
            guard let weatherTableViewController = segue.destination as? WeatherTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            weatherTableViewController.weatherController = (self.tabBarController as! MainTabBarViewController).weatherController
        }
    }
}

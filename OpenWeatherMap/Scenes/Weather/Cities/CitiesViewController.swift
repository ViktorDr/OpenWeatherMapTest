//
//  ViewController.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import UIKit
import MBProgressHUD
class CitiesViewController: BaseViewController {
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    let cityWeatherSegue = "CityWeatherSegue"
    let controllerTitle = "City List"
    
    var cities = [City]()
    var selectedCity: City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        loadCities()
    }
    
    func configureViews() {
        navigationItem.title = controllerTitle
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        citiesTableView.register(CityListCell.self)
    }
    
    func loadCities() {
        MBProgressHUD.showAdded(to: view, animated: true)
        StorageManager.shared.cities { [weak self] result in
            self?.cities = result
            if let view = self?.view {
                MBProgressHUD.hide(for: view, animated: true)
            }
            self?.citiesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == cityWeatherSegue,
            let weatherViewController = segue.destination as? CityWeatherViewController {
            weatherViewController.city = selectedCity
        }
    }

}


extension CitiesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.reuseKey, for: indexPath)
        if let cell = cell as? CityListCell, let city = cities[safe: indexPath.row] {
            cell.city.text = city.name ?? ""
            cell.country.text = city.country ?? ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[safe: indexPath.row]
        if city != nil {
            selectedCity = city
            performSegue(withIdentifier: cityWeatherSegue, sender: self)
        }
    }
}


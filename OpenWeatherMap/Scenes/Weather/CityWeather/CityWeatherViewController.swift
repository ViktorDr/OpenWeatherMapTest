//
//  CityWeatherViewController.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import UIKit
import MBProgressHUD
import MapKit

protocol CityWeatherViewProtocol : class {
    func updateView()
    func showProgressHUD()
    func hideProgressHUD()
    func showError(text : String)
    func updateNavigationBar(cityName name : String?, date : Date?)
}


class CityWeatherViewController: BaseViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityWeatherTableView: UITableView!
    
    var presenter : CityWeatherViewPresenter!
    var city : City?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        updateNavigationBar(cityName : city?.name, date : nil)
        presenter = CityWeatherPresenter(withView: self)
        presenter.downloadWeatherInformation(cityId: city?.id ?? 0)
    }

    func configureViews() {
        cityWeatherTableView.dataSource = self
        cityWeatherTableView.register(MainInfoCell.self)
        cityWeatherTableView.register(CityWeatherCell.self)
    }
    
    func updateNavigationBar(cityName name : String?, date : Date?) {
        navigationItem.title = (name ?? "") + " (\(date?.text ?? ""))"
    }
}

extension CityWeatherViewController : CityWeatherViewProtocol {
    
    func updateView() {
        let mapParameters = presenter.mapParameters()
        map.setMapVisibleArea(lat: mapParameters.lat, lng: mapParameters.lng, visibility: mapParameters.visibility)
        cityWeatherTableView.reloadData()
    }
    
    func showProgressHUD() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideProgressHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showError(text: String) {
        showAlertView(text, nil)
    }
    
}

extension CityWeatherViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.rowHeight(section: indexPath.section, row: indexPath.row) ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseKey = ""
        switch indexPath.section {
        case CityWeatherSection.weather.rawValue:
            reuseKey = CityWeatherCell.reuseKey
        case CityWeatherSection.mainInformation.rawValue:
            reuseKey = MainInfoCell.reuseKey
        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseKey, for: indexPath)
        if let cell = cell as? CityWeatherCell {
            let info = presenter.weatherMainInformation()
            cell.setInfo(main: info.main, description: info.description, imageAddress: info.imageAddress)
        }
        if let cell = cell as? MainInfoCell {
            let info = presenter.mainInfo(by: indexPath.row)
            cell.setInfo(title: info.title, value: info.value)
        }
        return cell
    }
}

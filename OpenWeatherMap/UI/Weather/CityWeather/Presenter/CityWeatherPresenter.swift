//
//  CityWeatherPresenter.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import UIKit

enum CityWeatherSection : Int {
    case weather = 0, mainInformation = 1
}

protocol CityWeatherViewPresenter : class {
    init(withView view: CityWeatherViewProtocol)
    func downloadWeatherInformation(cityId : Int?)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section : Int) -> Int
    func rowHeight(section : Int, row : Int) -> CGFloat?
    func mapParameters() -> (lat : Double, lng : Double, visibility : Int)
    func weatherMainInformation() -> (main : String?, description : String?, imageAddress : String)
    func mainInfo(by row : Int) -> (title : String, value : String)

}

class CityWeatherPresenter : CityWeatherViewPresenter {
    
    let noCityError = "There is no city like this"
    let unknownInfo = "?"
    let weatherMainInfoTitles = ["Temperature","Pressure","Humidity","Minimal t","Maximum t"]
    
    weak var view : CityWeatherViewProtocol?
    var cityWeather : CityWeather?
    var weatherMainInfoValues : [String]
    
    required init(withView view: CityWeatherViewProtocol)  {
        self.view = view
        weatherMainInfoValues  = Array(repeating: unknownInfo, count: weatherMainInfoTitles.count)
    }
    
    func downloadWeatherInformation(cityId : Int?) {
        guard cityId != nil else {
            self.view?.showError(text: noCityError)
            return
        }
        self.view?.showProgressHUD()
        APIWeather.shared.cityWeather(cityId: (cityId ?? 0)) { [weak self] (success, result) in
            guard let realSelf = self else {
                return
            }
            if success && !(result is Bool) {
                realSelf.cityWeather = result as? CityWeather
                realSelf.prepareMainInfoValues()
                realSelf.view?.updateNavigationBar(cityName: realSelf.cityWeather?.name ?? "", date: realSelf.cityWeather?.date)
                realSelf.view?.updateView()
            } else if let error = result as? String {
                    realSelf.view?.showError(text: error)
            }
            realSelf.view?.hideProgressHUD()
        }
    }
    
    func numberOfSections() -> Int {
        return cityWeather != nil ? 2 : 0
    }
    
    func prepareMainInfoValues() {
        weatherMainInfoValues.removeAll()
        self.weatherMainInfoValues.append(self.value(of: self.cityWeather?.mainInfo?.temperature))
        self.weatherMainInfoValues.append(self.value(of: self.cityWeather?.mainInfo?.pressure))
        self.weatherMainInfoValues.append(self.value(of: self.cityWeather?.mainInfo?.humidity))
        self.weatherMainInfoValues.append(self.value(of: self.cityWeather?.mainInfo?.minimalTemperature))
        self.weatherMainInfoValues.append(self.value(of: self.cityWeather?.mainInfo?.maximumTemperature))
    }
    
    func value<T> (of value: T?) -> String {
        if let realValue = value {
            return "\(realValue)"
        } else {
            return unknownInfo
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard cityWeather != nil else {
            return 0
        }
        switch section {
        case CityWeatherSection.weather.rawValue:
            return 1
        case CityWeatherSection.mainInformation.rawValue:
            return weatherMainInfoTitles.count
        default:
            return 0
        }
    }
    
    func rowHeight(section : Int, row : Int) -> CGFloat? {
        switch section {
        case CityWeatherSection.weather.rawValue:
            return 60
        case CityWeatherSection.mainInformation.rawValue:
            return 40
        default:
            return 0
        }
    }
    
    let defaultVisibility = 10000
    
    func mapParameters() -> (lat : Double, lng : Double, visibility : Int) {
        let latitude = cityWeather?.coordinate?.latitude ?? 0
        let longitude = cityWeather?.coordinate?.longitude ?? 0
        let visibility = cityWeather?.visibility ?? defaultVisibility
        return (lat : latitude, lng : longitude, visibility : visibility)
    }
    
    func weatherMainInformation() -> (main : String?, description : String?, imageAddress : String) {
        let weather = cityWeather?.weather?.first
        let main = weather?.main
        let descr = weather?.description
        let iconAddress = APIWeather.shared.imageIcon(weather?.icon ?? "")
        return (main : main, description : descr, imageAddress : iconAddress)
    }
    
    func mainInfo(by row : Int) -> (title : String, value : String) {
        return (title : weatherMainInfoTitles[row], value : weatherMainInfoValues[row])
    }
    
}

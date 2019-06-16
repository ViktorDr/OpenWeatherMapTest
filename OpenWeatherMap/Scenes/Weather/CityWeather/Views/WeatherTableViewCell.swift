//
//  WeatherTableViewCell.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import UIKit
import SDWebImage
class WeatherTableViewCell: BaseTableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var mainInfo: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(main : String?, description : String?, imageAddress : String) {
        self.mainInfo.text = main
        self.weatherDescription.text = description
        self.weatherIcon.sd_setImage(with: URL(string: imageAddress), placeholderImage: nil, completed: nil)
    }

}

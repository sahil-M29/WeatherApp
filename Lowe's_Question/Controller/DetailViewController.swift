//
//  Created by Sahil Mirchandani on 3/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    var element: List?
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var fellsLikeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        if let element = element{
            weatherImgView.image = getSFSymbol(weather: element.weather[0].main)
            tempLabel.text = "\(element.main.temp)"
            fellsLikeLabel.text = "feels like : \(element.main.feelsLike)"
            weatherLabel.text = element.weather[0].main.rawValue
            weatherDescription.text = element.weather[0].weatherDescription
        }
        // Do any additional setup after loading the view.
    }
    
    func getSFSymbol(weather: MainEnum) -> UIImage{
        switch weather {
        case .clear:
            return UIImage(systemName: "sun.max.fill")!
        case .clouds:
            return UIImage(systemName: "cloud.sun.fill")!
        case .rain:
            return UIImage(systemName: "cloud.rain.fill")!
        case .snow:
            return UIImage(systemName: "snow")!
        }
    }
}

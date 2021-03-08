//
//  Created by Sahil Mirchandani on 3/08/21.
//

import Foundation

let baseURL: String = "https://api.openweathermap.org/data/2.5/forecast"
let apiKey: String = "65d00499677e59496ca2f318eb68c049"
func createURL(city: String) -> String{
    let cityString = "q=\(city)"
    let apiString = "appid=\(apiKey)"
    let url = baseURL+"?\(cityString)&\(apiString)"
    return url
}

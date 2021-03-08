//
//  Created by Sahil Mirchandani on 3/08/21.
//

import UIKit

func makeAlert(title: String, body: String) -> UIAlertController{
    let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (Action) in

    }
    alert.addAction(okAction)
    return alert
}

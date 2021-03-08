//
//  Created by Sahil Mirchandani on 3/08/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lookUpButton: UIButton!
    @IBOutlet weak var cityNameField: UITextField!
    var textfield: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityNameField.delegate = self
        
        //handle keyborad layouts
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // handle UI when Keyboard is UP
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 170
            }
        }
    }
    // handle UI when Keyboard is DOWN
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // Enter Button pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lookUpButtonPressed(self)
        return true
    }
    
    // Lookup button pressed action
    @IBAction func lookUpButtonPressed(_ sender: Any) {
        let text = cityNameField.text
        
        // Handle cases when city name is invalid
        if(text == ""){
            let alert  = makeAlert(title: "Error", body: "City name cannot be empty")
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        // handle when city name has spaces
        if((text?.split(separator: " ").count)! > 1){
            textfield = (text?.replacingOccurrences(of: " ", with: "%20"))!
        }else{
            textfield = text!
        }
        
        // if everything is fine go to the table view
        performSegue(withIdentifier: segueIdentifiers.listView, sender: self)
    }
    
    
    // Pass the cityname to the table view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ListViewController
        vc.cityName = textfield.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}


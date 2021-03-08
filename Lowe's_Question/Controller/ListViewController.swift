//
//  Created by Sahil Mirchandani on 3/08/21.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTableview: UITableView!
    var cityName: String?
    var Data: DataModel?{
        didSet{
            DispatchQueue.main.async {
                self.listTableview.reloadData()
            }
        }
    }
    var NoDataFound = false{
        didSet{
            if NoDataFound == true{
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                    self.dismiss(animated: true, completion: nil)
                    })
            }
        }
    }
    var selectedIndex: Int = 0
    let networkClient = NetworkClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableview.register(ListTableViewCell.getUINib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        listTableview.delegate = self
        listTableview.dataSource = self
        reloadData()
        
    }
    
    func reloadData(){
        
        // Get data from the API
        if let cityName = cityName{
            print(cityName)
            //Call Network client for data
            networkClient.getData(city: cityName) { (dataModel) in
                print("found data")
                if let dataModel = dataModel{
                    
                    // If data found udate Data
                    self.Data = dataModel
                }else{
                    
                    //else throw an error
                    let alert = makeAlert(title: "Error", body: "No records found")
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                        self.NoDataFound = true
                    }
                }
            }
        }
    }
}


//MARK: - Table View
extension ListViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as! ListTableViewCell
        cell.seasonLabel.text = Data?.list[indexPath.row].weather[0].main.rawValue
        cell.temperatureLabel.text = "Temp: \(Int((Data?.list[indexPath.row].main.temp)!))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex  = indexPath.row
        performSegue(withIdentifier: segueIdentifiers.detailView, sender: self)
    }
}

//MARK: - Scroll View Animate
extension ListViewController{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)

        } else {
        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(false, animated: true)
            print("Unhide")
        }, completion: nil)
      }
   }
}

//MARK: - Prepare for segue
extension ListViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.element = Data?.list[selectedIndex]
    }
}

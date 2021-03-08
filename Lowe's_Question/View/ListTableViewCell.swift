//
//  Created by Sahil Mirchandani on 3/08/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func getUINib() -> UINib{
        return UINib(nibName: ListTableViewCell.identifier, bundle: nil)
    }
    
}

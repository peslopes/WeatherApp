
import Foundation
import UIKit


class CityDetailsView : UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues(name: "", buttonTitle: "")
    }
    
    func setInitialValues(name: String, buttonTitle: String) {
        cityNameLabel.text = name
        cityNameLabel.font = UIFont(name: "Helvetica-Neue", size: 30)
        cityButton.backgroundColor = .black
        cityButton.setTitle(buttonTitle, for: .normal)
    }
    
}

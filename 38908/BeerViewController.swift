import UIKit
import Kingfisher

class BeerViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbAbv: UILabel!
    @IBOutlet weak var lbIbu: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbAbvVal: UILabel!
    @IBOutlet weak var lbIbuVal: UILabel!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbName.text = beer.name
        lbTagline.text = beer.tagline
        lbDescription.text = beer.description
        lbAbvVal.text = "\(beer.abv)"
        lbIbuVal.text = "\(beer.ibu)"
        let url_image = URL(string: beer.image_url)
        ivImage.kf.setImage(with: url_image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BeerViewController {
            vc.beer = beer
        }
    }
    
}

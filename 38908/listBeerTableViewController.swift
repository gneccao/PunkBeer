import UIKit
import Kingfisher

class listBeerTableViewController: UITableViewController {

    var dataSource: [Beer] = []
    var idSelect: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBeers()
    }

    func loadBeers(){
        Rest.loadBeers { (beers: [Beer]?) in
            if let beers = beers {
                self.dataSource = beers
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        idSelect = indexPath.row
        return indexPath
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let Viewc = segue.destination as? BeerViewController {
            Viewc.beer = dataSource[idSelect]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as!BeerTableViewCell
        
        let beer = dataSource[indexPath.row]
        cell.lbName.text = beer.name
        cell.lbAbv.text = " Teor alcoólico: \(beer.abv)"
        let url_image = URL(string: beer.image_url)
        cell.ivImage.kf.setImage(with: url_image)
        
        return cell
    }
}

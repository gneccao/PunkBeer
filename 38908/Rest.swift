import Foundation

class Rest {
    
    static let basePath = "https://api.punkapi.com/v2/beers"
    
    static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 3
        
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
    
    
    static func loadBeers(onComplete: @escaping ([Beer]?) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                onComplete(nil)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    var beers: [Beer] = []
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                        
                        
                        for item in json {
                            let image_url = item["image_url"] as! String
                            let name = item["name"] as! String
                            let tagline = item["tagline"] as! String
                            let abv = item["abv"] as! Float
                            let ibu = (item["ibu"] as? Float) ?? 0.0
                            let description = item["description"] as! String
                            let id = item["id"] as! Int
                            let beer = Beer(id: id, image_url: image_url,name: name,tagline: tagline,abv: abv,ibu: ibu,description: description)
                            beers.append(beer)
                        }
                    } catch {
                        onComplete(nil)
                        return
                    }
                    onComplete(beers)
                } else {
                    onComplete(nil)
                }
            }
        }.resume()
    }
}

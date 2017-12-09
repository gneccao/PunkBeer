import Foundation

class Beer {
    var image_url: String
    var name: String
    var tagline: String
    var abv: Float
    var ibu: Float
    var description: String
    var id: Int
    
    init(id: Int, image_url: String, name: String, tagline: String, abv: Float, ibu: Float, description: String){
        
        self.id = id
        self.image_url = image_url
        self.name = name
        self.tagline = tagline
        self.abv = abv
        self.ibu = ibu
        self.description = description
    }
}

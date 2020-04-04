//
//  Product.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//
import UIKit
class Product {

    var id: String
    var productName: String?
    var productImageURL: String?
    var productPrice: Double?
    var productDescription: String?
    var productCategory: String?
    var productImages: [String]?

    init(id: String, name: String, imageUrl: String, price: Double, description: String, category: String, images: [String]) {
        self.id = id
        productName = name
        productImageURL = imageUrl
        productPrice = price
        productDescription = description
        productCategory = category
        productImages = images
    }

    static func mockProducts() -> [Product] {
        let url = "http://45.119.84.18:1111/api/products/?start=5&limit=10"
            
                let request = NSMutableURLRequest(url: URL(string: url)!)
  
                let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
                    if (error != nil) {
                        print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
                    }
                    if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
                        print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                        print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
                    }
            
                    let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("responseString = \(responseAPI)") // Affiche dans la console la réponse de l'API
            
                    if error == nil {
                        // Ce que vous voulez faire.
                    }
                }
                requestAPI.resume()
        
        
        let images = [
            "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-6.jpeg",
            "http://iosapptemplates.com/wp-content/uploads/2017/03/dress11.jpg",
            "http://iosapptemplates.com/wp-content/uploads/2017/03/dress12.jpg",
            "http://iosapptemplates.com/wp-content/uploads/2017/03/dress13.jpg"
        ]

        let suitImages = [
            "http://iosapptemplates.com/wp-content/uploads/2017/02/executivesuits.jpeg"
        ]

        let description = "    To these in the morning, I sent the captain, who was to enter into a parley with them. In a word, to try them and tell me wheather they might be trusted or not to go on board and surprise the ship."
        return [
            Product(id: "12", name: "Traveler Traditional", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/travelertraditionalsuit.jpeg", price: 278.00, description: description, category: "Suits", images: suitImages),
            Product(id: "13", name: "Ralph Lauren", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/executivesuits.jpeg", price: 760, description: description, category: "Suits", images: suitImages),
            Product(id: "14", name: "Hugo Boss", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/hugobosssuit.jpeg", price: 690, description: description, category: "T-Shirt", images: suitImages),
            Product(id: "15", name: "Signature Tailor", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/signaturetailoredsuit.jpg", price: 999, description: description, category: "Suits", images: suitImages),
            Product(id: "16", name: "Joseph Slim", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/josephslimsuit.jpeg", price: 459.0, description: description, category: "Suits", images: suitImages),
            Product(id: "122", name: "Jack Victor", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/jackvictorgibsonsuit.jpg", price: 360, description: description, category: "Suits", images: suitImages),
            Product(id: "12873", name: "Calvin Klein", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/02/calvinkleinsuit.jpg", price: 780, description: description, category: "Suits", images: suitImages),
            Product(id: "17623", name: "Red dress", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-1.jpeg", price: 780, description: description, category: "Dresses", images: images),
            Product(id: "17623", name: "Zara", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-2.jpeg", price: 74, description: description, category: "Dresses", images: images),
            Product(id: "1223", name: "Mohito", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-8.jpeg", price: 80, description: description, category: "Dresses", images: images),
            Product(id: "12343", name: "Asos", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-4.jpeg", price: 69, description: description, category: "Dresses", images: images),
            Product(id: "15623", name: "Pimkie", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-5.jpeg", price: 54, description: description, category: "Dresses", images: images),
            Product(id: "16523", name: "Elie Saab", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-6.jpeg", price: 199, description: description, category: "Dresses", images: images),
             Product(id: "4763", name: "H&M", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-7.jpeg", price: 47, description: description, category: "Dresses", images: images),
              Product(id: "455", name: "Victoria Beckham", imageUrl: "http://iosapptemplates.com/wp-content/uploads/2017/03/dress-8.jpeg", price: 99, description: description, category: "Dresses", images: images),
        ]
    }
}

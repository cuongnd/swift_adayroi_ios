//
//  ProductCollectionViewController.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Material
import UIKit

private let reuseIdentifier = "ProductCollectionViewCell"

class ProductCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var products: [Product] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }

    var data1 = [Product]();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.DATA()
    }

    func DATA() {
        let url = "http://45.119.84.18:1111/api/products/?start=0&limit=100"

        let request = NSMutableURLRequest(url: URL(string: url)!)

        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    do {
                        //array
                        let my_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(my_json);
                        self.data1 = my_json as! [Product]
                        self.collectionView?.reloadData()
                    } catch {

                    }
                }
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
            }


            if error == nil {
                // Ce que vous voulez faire.
            }
        }
        requestAPI.resume()


    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data1.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.configureCell1(product: "sdfsdf")
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = StoryboardEntityProvider().ecommerceProductDetailsVC()
        detailsVC.product = data1[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumCellSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing = minimumCellSpacing()
        return UIEdgeInsetsMake(5, spacing, 5, spacing)
    }

    fileprivate func minimumCellSpacing() -> CGFloat {// The cell's size is 142 x 216
        let width = self.collectionView!.frame.size.width - 5
        let cellsPerRow = CGFloat(Int(width / 142.0))
        return (width - cellsPerRow * 142) / (cellsPerRow + 1)
    }
}

//
//  HomeViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDataSource,UICollectionViewDataSource,UIScrollViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet fileprivate weak var slideShowCollectionView: UICollectionView!

    fileprivate let photos = [
        "Dakota Johnson",
        "Dakota Johnson",
        "Dakota Johnson",
        "Dakota Johnson",
        "Dakota Johnson"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        slideShowCollectionView.dataSource=self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text="hello"
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width / 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath);
        
        
        return cell
    }
    
    
 
    
}


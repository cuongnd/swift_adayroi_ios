//
//  UserViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/29/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class UserRegisterViewController: LibMvcViewController {
    fileprivate var firebaseEnabled = false
    fileprivate var loggedInViewController: ATCHostViewController? = nil
    @IBOutlet weak var UIButtonGoToLogin: UIButton!
   
    
    
    override func viewDidLoad() {
        print("hello UserViewController")
        super.viewDidLoad()
        UIButtonGoToLogin.addTarget(self, action: #selector(didTapGoToLoginButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    fileprivate func didTapGoToLoginButton() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginVC = ATCViewControllerFactory.createLoginViewController(firebaseEnabled: AppConfiguration.isFirebaseIntegrationEnabled, loggedInViewController: appDelegate.hostViewController!)
        
        print("hello didTapGoToLoginButton 123")
        self.present(loginVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

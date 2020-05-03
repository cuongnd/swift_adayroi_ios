//
//  AppDelegate.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Fabric
import FacebookCore
import FacebookLogin
import FacebookShare
import Firebase
import Material
import Stripe
import TwitterKit
import UIKit
import GoogleMaps
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var cartManager = ShoppingCartManager()
    fileprivate var cartButton: IconButton!

    var hostViewController: ATCHostViewController?
    var loginVC:ATCLoginViewController?
    func googleMapSetup(){
        //AIzaSyCNaQlvaBEHQHaCAwEjphOhJQ2g8fj3OOs
        GMSServices.provideAPIKey("AIzaSyCNaQlvaBEHQHaCAwEjphOhJQ2g8fj3OOs")
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        googleMapSetup()
        self.configureHostViewControllers()
        if (AppConfiguration.isLoginScreenEnabled) {
            if (AppConfiguration.isTwitterLoginEnabled) {
                Fabric.with([Twitter.self])
            }
            if (AppConfiguration.isFirebaseIntegrationEnabled) {
                FIRApp.configure()
            }
            if (AppConfiguration.isStripePaymentEnabled) {
                STPPaymentConfiguration.shared().publishableKey = AppConfiguration.stripePublishableKey
            }
            if (AppConfiguration.isApplePaymentEnabled) {
                STPPaymentConfiguration.shared().appleMerchantIdentifier = AppConfiguration.applePayMerchantIdentifier
            }
            if (AppConfiguration.isFacebookLoginEnabled) {
                return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
            }
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AppConfiguration.isLoginScreenEnabled && AppConfiguration.isFacebookLoginEnabled) {
            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return true
    }

    func configureHostViewControllers() {
        let user:User=Factory.getUser()
        
        
        // Home view controller - the categories screen

        let homeVC = StoryboardEntityProvider().homeVC()
        
        homeVC.title = "iShop"

        // Checkout/Cart View Controller - the checkout screen, containing the products in the card

        NotificationCenter.default.addObserver(self, selector: #selector(didSendAddToCartNotification), name: kNotificationDidAddProductToCart, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didClearCartNotification), name: kNotificationDidAClearCart, object: nil)

        
       
        
        
        let cartViewController = StoryboardEntityProvider().ecommerceCartVC()
        cartViewController.cartManager = cartManager
        cartViewController.title = StringConstants.kShoppingCartString

        // Settings view controller - user settings screen
        let action = { (_ viewController: UIViewController?) -> (Void) in
            print("Settings button pressed from viewController")
            /**
             * Use this completion block to handle the actions taken by users on each settings item
             * You can even present other view controllers using the line above:

             * viewController?.navigationController?.pushViewController(newViewController, animated: true)
             */
            let ecommerceCartVC = StoryboardEntityProvider().ecommerceCartVC()
            viewController?.navigationController?.pushViewController(ecommerceCartVC, animated: true)
        }
        let go_to_my_order = { (_ viewController: UIViewController?) -> (Void) in
            let ecommerceCartVC = StoryboardEntityProvider().get_view_and_layout(view:"Orders",controller:"Orders")
            viewController?.navigationController?.pushViewController(ecommerceCartVC, animated: true)
        }

        let settingsItemProfile = ATCSettingsItem(title: "Profile", style: .more, action: action)
        let settingsItemMyOrder = ATCSettingsItem(title: "My order", style: .more, action: go_to_my_order)
        let settingsItemPayment = ATCSettingsItem(title: "Payment Info", style: .text, action: action)
        let settingsItemEmail = ATCSettingsItem(title: "Email Notifications", style: .toggle, action: action, toggleValue: false)
        let settingsItemPushNotifications = ATCSettingsItem(title: "Push Notifications", style: .toggle, action: action, toggleValue: true)
        let settingsItemPrivacyPolicy = ATCSettingsItem(title: "Privacy Policy", style: .more, action: action)
        let settingsItemTermsConditions = ATCSettingsItem(title: "Terms & Conditions", style: .more, action: action)
        let settingsItems = [settingsItemProfile,settingsItemMyOrder, settingsItemPayment, settingsItemEmail, settingsItemPushNotifications, settingsItemPrivacyPolicy, settingsItemTermsConditions]
        let settingsVC = ATCSettingsTableViewController(settings: settingsItems, nibNameOrNil: nil, nibBundleOrNil: nil)
        settingsVC.title = StringConstants.kSettingsString

        // Navigation Item - Configuration for sidebar menu / TabBar

        let homeMenuItem = ATCNavigationItem(title: StringConstants.kHomeString, viewController: homeVC, image: UIImage(named: "shop-menu-icon"), type: .viewController)
        let cardMenuItem = ATCNavigationItem(title: StringConstants.kShoppingCartString, viewController: cartViewController, image: UIImage(named: "shopping-cart-menu-item"), type: .viewController)
        let settingsMenuItem = ATCNavigationItem(title: StringConstants.kSettingsString, viewController: settingsVC, image: UIImage(named: "settings-menu-item"), type: .viewController)
        let logoutMenuItem = ATCNavigationItem(title: StringConstants.kLogoutString, viewController: UIViewController(), image: UIImage(named: "logout-menu-item"), type: .logout)

        let menuItems = [homeMenuItem, cardMenuItem, settingsMenuItem, logoutMenuItem]

        // Cart button on the top right navigation
        prepareCartButton()
        let topRightNavigationViews = [cartButton!]
        hostViewController = ATCHostViewController(style: .sideBar, items: menuItems, topNavigationRightViews: topRightNavigationViews)

        window = UIWindow(frame: UIScreen.main.bounds)
        self.loginVC = ATCViewControllerFactory.createLoginViewController(firebaseEnabled: AppConfiguration.isFirebaseIntegrationEnabled, loggedInViewController: hostViewController!)
        if (AppConfiguration.isLoginScreenEnabled && user.id.isEmpty) {
             print("123")
            window!.rootViewController = self.loginVC
        }else if (AppConfiguration.isLoginScreenEnabled && !user.id.isEmpty) {
            // Configure the some mock current user data
            print("456")
            let avatarURL = "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12801222_1293104680705553_7502147733893902564_n.jpg?oh=b151770a598fea1b2d6b8f3382d9e7c9&oe=593E48A9"
            let user = ATCUser(firstName: "John", lastName: "Smith", avatarURL: avatarURL)
            hostViewController?.user = user
            window!.rootViewController = hostViewController
        } else {
            print("789")
            // Configure the some mock current user data
            let avatarURL = "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12801222_1293104680705553_7502147733893902564_n.jpg?oh=b151770a598fea1b2d6b8f3382d9e7c9&oe=593E48A9"
            let user = ATCUser(firstName: "John", lastName: "Smith", avatarURL: avatarURL)
            hostViewController?.user = user
            window!.rootViewController = hostViewController
        }
        window!.makeKeyAndVisible()
    }

    // Shopping Cart Mananger

    func addProduct(product: Product) {
        cartManager.addProduct(product: product)
        self.updateCartButton()
    }

    fileprivate func updateCartButton() {
        let count = cartManager.productCount()
        var title = ""
        if count > 0 {
            title = "\(count)"
        }
        cartButton.setTitle(title, for: .normal)
    }

    @objc
    fileprivate func didSendAddToCartNotification(notification: Notification) {
        print("1111")
        guard let product = notification.userInfo?["product"] as? Product else {
            return
        }
        print("22222")
        self.addProduct(product: product)
    }

    @objc
    fileprivate func didClearCartNotification(notification: Notification) {
        self.updateCartButton()
    }

    fileprivate func prepareCartButton() {
        cartButton = IconButton(image: UIImage(named: "shopping-cart-menu-item"))
        cartButton.backgroundColor = Color.green.base
        cartButton.addTarget(self, action: #selector(handleCartButton), for: .touchUpInside)
        cartButton.titleColor = .white
        cartButton.layer.cornerRadius = 5
    }

    @objc
    fileprivate func handleCartButton() {
        let cartIndexPath = IndexPath(row: 1, section: 0)
        hostViewController?.menuViewController?.selectMenuItemAtIndexPath(indexPath: cartIndexPath)
    }
    
    
   
}


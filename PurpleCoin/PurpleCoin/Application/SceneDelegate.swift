//
//  SceneDelegate.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit
import DIContainer_swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    public var navController = UINavigationController()
    var mainViewController: UIViewController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        do {
            let apiService: APIService = try Container.standard.resolve(.by(type: APIService.self,  key: NetworkServiceConfig.upbitDIKey))
            mainViewController = MainViewController(apiService: apiService)
            self.navController = UINavigationController(rootViewController: mainViewController!)
            self.navController.navigationBar.isHidden = true
            self.window?.rootViewController = self.navController
            self.window?.makeKeyAndVisible()
        } catch let err {
            print(err)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}


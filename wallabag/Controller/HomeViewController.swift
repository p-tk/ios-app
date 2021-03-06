//
//  HomeViewController.swift
//  wallabag
//
//  Created by maxime marinel on 24/10/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!

    @IBAction func openWallabagIt(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "https://www.wallabag.it/en?pk_campaign=register&pk_kwd=wallabagapp")!)
    }

    @IBAction func disconnect(segue: UIStoryboardSegue) {
        registerButton.isEnabled = true
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.resetApplication()
    }

    override func viewDidLoad() {
        if let server = Setting.getServer() {
            WallabagApi.configureApi(from: server)
            WallabagApi.requestToken { success, _ in
                if success {
                    self.performSegue(withIdentifier: "toArticles", sender: nil)
                } else {
                    self.registerButton.isEnabled = true
                }
            }
        } else {
            registerButton.isEnabled = true
        }
    }
}

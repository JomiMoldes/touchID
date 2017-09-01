//
//  ViewController.swift
//  TouchIDCredentials
//
//  Created by MIGUEL MOLDES on 31/8/17.
//  Copyright © 2017 MIGUEL MOLDES. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 100, y: 100, width: 200.0, height: 200.0)
        button.setTitle("Check", for: .normal)
        
        button.setTitleColor(UIColor.red, for: .normal)

        self.view.addSubview(button)

        button.addTarget(self, action: #selector(pressed), for: .touchUpInside )

        let secItemWrapper = SecItemWrapper()
        let keychainMgr = KeychainAccessManager(secItemWrapper: secItemWrapper)
//        storeCredentials(keychainMgr)
        checkCredentials(keychainMgr)
//        keychainMgr.updateCredentials(userName: "Miguel2", password: "Miguel23")
//      keychainMgr.checkCredentials(userName:"Miguel3")
//        keychainMgr.deleteCredentials(userName: "Miguel2")
    }

    func storeCredentials(_ keychainMgr:KeychainAccessProtocol) {
        let status = keychainMgr.storeCredentials(userName: "Miguel2", password: "Miguel22")
        switch status {
            case errSecSuccess:
                print("success saving password")
                break
            case errSecDuplicateItem:
                print("duplicated item in the keychain")
                break
            default:
                print("app couldn't save password")
                break
        }
    }

    func checkCredentials(_ keychainMgr:KeychainAccessProtocol) {
        keychainMgr.checkCredentials(userName: "Miguel2").then {
          status -> Void in
            switch status {
            case errSecSuccess:
                print("success matching item from keychain")
                break
            case errSecItemNotFound:
                print("item not found in the keychain")
                break
            default:
                print("app couldn't find password")
                break
            }
      }.catch(policy:.allErrors) {
          error in
          print(error)
      }
    }

    func pressed(_ sender:UIEvent) {
        checkID()
    }

    private func checkID() {
        let touchID = TouchIDManager()
        touchID.checkID(completion: {
            success in
            if success {
                print("todo joya")
                return
            }
            print("no funcó")
        })

    }
}


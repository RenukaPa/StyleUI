//
//  ViewController.swift
//  StyleUI
//
//  Created by renukapandey90@gmail.com on 07/29/2022.
//  Copyright (c) 2022 renukapandey90@gmail.com. All rights reserved.
//

import UIKit
import StyleUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkAlertView(_ sender: Any) {
        let alert = TriggerAlertView()
        alert.setAlert(message: "Testing zdv sdfsd sdfsdf sfsdf werwer werwer werwer sefe fwerwer werwer sdfsdf werwer werwer sdfsd esfd ewrwer werwer werwer sdfsdf sdfsdf sdfdsf wefds", type: .warn)
    }
}


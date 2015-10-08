//
//  ViewController.swift
//  Sample
//
//  Created by LeeSunhyoup on 2015. 9. 27..
//  Copyright © 2015년 KCSelectionView. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSelectionDialog() {
        let dialog = KCSelectionDialog(title: "Dialog", closeButtonTitle: "Close")
        dialog.addItem(KCSelectionDialogItem(item: "Test1", icon: UIImage(named: "Icon1")!, didTapHandler: { () in
            print("Test1 didTap!")
        }))
        dialog.addItem(KCSelectionDialogItem(item: "Test2", icon: UIImage(named: "Icon2")!, didTapHandler: { () in
            print("Test2 didTap!")
        }))
        dialog.addItem(KCSelectionDialogItem(item: "Test3", icon: UIImage(named: "Icon3")!, didTapHandler: { () in
            print("Test3 didTap!")
        }))
        dialog.show()
    }

}


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
        let dialog = SelectionDialog(title: "Dialog", closeButtonTitle: "Close")
        
        dialog.addItem(item: "I have icon :)",
                       icon: UIImage(named: "Icon1")!)
        
        dialog.addItem(item: "I have icon and handler :D",
                       icon: UIImage(named: "Icon2")!,
                       didTapHandler: { () in
                        print("Item didTap!")
        })
        
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.addItem(item: "I have nothing :(")
        dialog.show()
    }

}


//
//  ViewController.swift
//  ImageActionSheet
//
//  Created by Bisma Saeed on 21.05.20.
//  Copyright © 2020 Bisma Saeed. All rights reserved.
//

import UIKit
import ImageActionSheet

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nativeAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Upload a file", message: "Please choose a file.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Document", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        let actionSheet = BSImageActionSheet(title: "Upload a file", message: "Please choose a file.")
        actionSheet.add(action: BSAlertAction(title: "Camera", icon: UIImage(named: "camera"), action: {
            print("Camera clicked")
        }))
        actionSheet.add(action: BSAlertAction(title: "Gallery", icon: UIImage(named: "gallery"), action: {
            print("Gallery clicked")
        }))
        
        actionSheet.add(action: BSAlertAction(title: "Document", icon: UIImage(named: "file"), action: {
            print("Document clicked")
        }))
        
        actionSheet.show()
        
    }
    
}


//
//  ViewController.swift
//  Lab8_2
//
//  Created by admin on 5/21/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(ImageOutlet.frame.size);
                
                let context=UIGraphicsGetCurrentContext();
                
                context?.setLineWidth(10);
                
                
        Drawing.Draw8Angle(context: context!, x: 200, y: 300, circumRadius: 140);

                
                ImageOutlet.image=UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
        // Do any additional setup after loading the view.
    }
    
    
    
}


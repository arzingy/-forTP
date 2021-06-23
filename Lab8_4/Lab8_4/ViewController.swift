//
//  ViewController.swift
//  Lab8_4
//
//  Created by admin on 5/21/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.isUserInteractionEnabled = true
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 2
        label.text = "Используйте жесты в этой области"
        label.backgroundColor = UIColor.yellow
    }

    @IBAction func tap(_ sender: Any) {
        label.text = "Жест: касание\n Цвет фона: зеленый"
        label.backgroundColor = UIColor.green
    }
    
    @IBAction func longPress(_ sender: Any) {
        label.text = "Жест: долгое нажатие\n Цвет фона: оранжевый"
        label.backgroundColor = UIColor.orange
    }
    
    @IBAction func pinch(_ sender: Any) {
        label.text = "Жест: масштабирование\n Цвет фона: красный"
        label.backgroundColor = UIColor.red
    }
    
    @IBAction func rotation(_ sender: Any) {
        label.text = "Жест: вращение\n Цвет фона: синий"
        label.backgroundColor = UIColor.blue
    }
    
    @IBAction func swipe(_ sender: Any) {
        label.text = "Жест: смахивание\n Цвет фона: серый"
        label.backgroundColor = UIColor.lightGray

    }
    
    
}


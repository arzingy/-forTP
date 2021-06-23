import UIKit

class ViewController: UIViewController {
    var flag = false
    let options: UIView.AnimationOptions = [.repeat,.autoreverse];
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gr = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        imageView.addGestureRecognizer(gr)
        imageView.isUserInteractionEnabled = true
        
        let gr1 = UITapGestureRecognizer(target: self, action: #selector(gestureTap(_:)))
        imageView.addGestureRecognizer(gr1)
        
        let gr2 = UIPinchGestureRecognizer(target: self, action: #selector(gesturePinch(_:)))
        imageView.addGestureRecognizer(gr2)
        
        let gr3 = UILongPressGestureRecognizer(target: self, action: #selector(gestureLongPress(_:)))
        imageView.addGestureRecognizer(gr3)
        
        let gr4 = UIRotationGestureRecognizer(target: self, action: #selector(gestureRotation(_:)))
        imageView.addGestureRecognizer(gr4)
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(10)
        
        let lay = Drawer.DrawPentagon(x: imageView.frame.width / 2, y: imageView.frame.width/4, circumRadius: 40)
        
        imageView.layer.addSublayer(lay)
        
        let layer2 = Drawer.DrawSixLeaf(x: imageView.frame.width / 2, y: imageView.frame.width*3/4, circumRadius: 30)
        imageView.layer.addSublayer(layer2)
    
        //let layy = Drawer.DrawUnion(x: imageView.frame.width / 2, y: imageView.frame.width/4, circumRadius: 40)
        //imageView.layer.addSublayer(layy)
    }
    
    @objc func gestureSwipe(_ gesture: UISwipeGestureRecognizer){
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "Moscow.png")!)
    }
    
    @objc func gestureTap(_ gesture: UITapGestureRecognizer){
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "Minsk.png")!)
    }
    
    @objc func gesturePinch(_ gesture: UIPinchGestureRecognizer){
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "Omsk.png")!)
    }
    
    @objc func gestureLongPress(_ gesture: UILongPressGestureRecognizer){
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "Grodno.png")!)
    }
    
    @objc func gestureRotation(_ gesture: UIRotationGestureRecognizer){
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "Gov.png")!)
    }
    
    @IBAction func trans_pressed(_ sender: Any) {
        UIView.animate(withDuration: 3, delay: 0, options: options, animations: {
                   
            self.imageView.backgroundColor=self.imageView.backgroundColor?.withAlphaComponent((self.imageView.backgroundColor?.cgColor.alpha)!-0.5);
                      })
    }
    @IBAction func rotate_pressed(_ sender: Any) {
        UIView.animate(withDuration: 3, delay: 0, options: options, animations: {
            
            self.imageView.transform=self.imageView.transform.rotated(by: 20);
               })
    }
    @IBAction func size_pressed(_ sender: Any) {
        UIView.animate(withDuration: 3, delay: 0, options: options, animations: {
            
            self.flag = !self.flag
                
            for layer: CALayer in self.imageView.layer.sublayers! {
                    layer.removeFromSuperlayer()
                }
            var coeff = 1.0
            if self.flag {
                coeff = 1.0
            } else {
                coeff = 1/2.0
            }
            let lay = Drawer.DrawPentagon(x: self.imageView.frame.width / 2, y: self.imageView.frame.width/4, circumRadius: CGFloat(40*coeff))
            
            self.imageView.layer.addSublayer(lay)
            
            let layer2 = Drawer.DrawSixLeaf(x: self.imageView.frame.width / 2, y: self.imageView.frame.width*3/4, circumRadius: CGFloat(30*coeff))
            self.imageView.layer.addSublayer(layer2)
               })
    }
    @IBAction func move_pressed(_ sender: Any) {
        UIView.animate(withDuration: 3, delay: 0, options: options, animations: {
               
       self.imageView.transform=self.imageView.transform.translatedBy(x: 50, y: 0);
           })
    }
}


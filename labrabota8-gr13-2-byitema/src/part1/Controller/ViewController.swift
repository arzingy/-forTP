import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorControl: UISegmentedControl!
    @IBOutlet weak var widthControl: UISegmentedControl!
    var lastPoint: CGPoint = CGPoint(x:0, y:0)
    var drawingColor = UIColor.black
    @IBOutlet weak var canvas: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        lastPoint = (touch?.location(in: self.canvas))!
        
        if colorControl.selectedSegmentIndex == 0 {
            self.drawingColor = UIColor.black
        } else if colorControl.selectedSegmentIndex == 1 {
            self.drawingColor = UIColor.green
        } else if colorControl.selectedSegmentIndex == 2 {
            self.drawingColor = UIColor.red
        } else if colorControl.selectedSegmentIndex == 3 {
            self.drawingColor = UIColor.yellow
        } else if colorControl.selectedSegmentIndex == 4 {
            self.drawingColor = UIColor.blue
        }
    }
    
    @IBAction func widthControl(_ sender: Any) {
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        let currentPoint = (touch?.location(in: self.canvas))!
        
        UIGraphicsBeginImageContext(self.canvas.frame.size)
        
        let drawRect = CGRect.init(x: 0.0, y: 0.0, width: self.canvas.frame.width, height: self.canvas.frame.height)
        self.canvas.image?.draw(in: drawRect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(drawingColor.cgColor)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(widthControl.selectedSegmentIndex + 5))
        context?.beginPath()
        context?.move(to: lastPoint)
        context?.addLine(to: currentPoint)
        context?.strokePath()
        
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }
    
    @IBAction func save_button_pressed(_ sender: Any) {
        let imageData = canvas.image!.pngData()
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
    }
}

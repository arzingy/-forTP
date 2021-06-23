import Foundation
import UIKit

class MainViewController : UIViewController{
    
    @IBOutlet weak var RegView: UIView!
    @IBOutlet weak var PasswordInputField: UITextField!
    @IBOutlet weak var LoginReg: UITextField!
    @IBOutlet weak var LoginAuth: UITextField!
    @IBOutlet weak var PassAuth: UITextField!
    
    @IBOutlet weak var PassReg: UITextField!
    @IBOutlet weak var EmailReg: UITextField!
    @IBOutlet weak var RepPassReg: UITextField!
    @IBOutlet weak var LOginRegSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
       super.viewDidLoad()
    
       RegView.isHidden=true;
    }
   
    @IBAction func ButtonLoginCLicked(_ sender: Any) {
        if(UserDefaults.standard.object(forKey: LoginAuth.text!) != nil && UserDefaults.standard.object(forKey: LoginAuth.text!) as! String == PassAuth.text)
        {
              performSegue(withIdentifier: "FromStartToMain", sender: self);
        }
    }

   @IBAction func StetSwitch(_ sender: Any) {
       if(LOginRegSwitch.selectedSegmentIndex == 1){
           RegView.isHidden=false;
       }
       else{
           RegView.isHidden=true;
       }
       
   }
    
   @IBAction func RegConfButton(_ sender: Any) {
    UserDefaults.standard.set(LoginReg.text!,forKey: PassReg.text!)

       performSegue(withIdentifier: "FromStartToMain", sender: self);
   }
}

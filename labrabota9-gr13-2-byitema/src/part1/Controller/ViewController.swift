import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var DescriptionField: UITextView!
    
    var InfoList = NSDictionary();
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        InfoList.count;
    }
    
    @IBOutlet weak var ViewCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieInfo = (InfoList.object(forKey: ((InfoList.allKeys ) [indexPath.row]))) as! NSDictionary;
        
        DescriptionField.text=NSLocalizedString(movieInfo.object(forKey: "Description") as! String, comment: "Comment");
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MovieCell;
        
        // Configure the cell
        
        let movieInfo = (InfoList.object(forKey: ((InfoList.allKeys ) [indexPath.row]))) as! NSDictionary;
        
        cell.Name.text = NSLocalizedString((InfoList.allKeys ) [indexPath.row] as! String, comment: "Comment");
        cell.Icon.image = UIImage(named: movieInfo.object(forKey: "Icon") as! String);
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "MovieInfo", ofType: "plist")
        InfoList = NSDictionary(contentsOfFile:filePath!)!
    }
}


import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate, WeatherGetterDelegate {
    
    func didNotGetWeather(error: NSError) {
        
    }
    
    var foundMuseums = [NSManagedObject]();
    var weather : WeatherGetter!;
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var Map: MKMapView!
    
    var points = [CLLocationCoordinate2D]() {
        didSet {
            print(points)
        }
    }
    
    @objc func longPressed(recognizer: UILongPressGestureRecognizer) {
        Map.removeOverlays(Map.overlays)
        if recognizer.state == .ended {
            let coordinate = Map.convert(recognizer.location(in: Map), toCoordinateFrom: Map)
            points.append(coordinate)
            MarkLocation(title: "", location: coordinate)
            
            var searchRequest = NSFetchRequest<Museum>(entityName: "Museum");
            
            searchRequest.predicate = NSPredicate(format: "longitude BETWEEN {%lf, %lf} && latitude BETWEEN {%lf, %lf}", coordinate.longitude - 0.01, coordinate.longitude + 0.01, coordinate.latitude - 0.01, coordinate.latitude + 0.01);
            
            try! foundMuseums = appDelegate.persistentContainer.viewContext.fetch(searchRequest);
            
            table.reloadData();
        }
    }
    
    private var locationManager = LocationManager();
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foundMuseums.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: "MuseumCell", for: indexPath) as! MuseumCell;
        
        var museum = foundMuseums[indexPath.row];
        
        cell.Museum.text = NSLocalizedString(museum.value(forKey: "museum") as! String, comment: "Comment");
        cell.Address.text = NSLocalizedString(String(museum.value(forKey: "address") as! String), comment: "Comment");
        cell.Exhibitions.text = NSLocalizedString(String(museum.value(forKey: "exhibitions") as! String), comment: "Comment");
        
        return cell;
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        DisplayWeather(location: view.annotation!.coordinate);
    }
    
    private func DisplayWeather(location: CLLocationCoordinate2D){
        weather.getWeatherByCoordinates(latitude: location.latitude, longitude: location.longitude);
    }
    
    func didGetWeather(weather: Weather) {
      // This method is called asynchronously, which means it won't execute in the main queue.
      // All UI code needs to execute in the main queue, which is why we're wrapping the code
      // that updates all the labels in a dispatch_async() call.
      DispatchQueue.main.async{
        

        var weatherInfo = "";
        weatherInfo += String( weather.tempCelsius)+" C \n";

        weatherInfo += weather.weatherDescription+"\n";
        
        let alert = UIAlertController(title:NSLocalizedString("Weather", comment: "Comment"), message: weatherInfo, preferredStyle: UIAlertController.Style.actionSheet)
        alert.preferredContentSize = self.preferredContentSize;
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Comment"), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
    
    private func MarkLocation(title: String, location: CLLocationCoordinate2D){
        
        var annotation = MKPointAnnotation();
        annotation.coordinate = location;
        annotation.title = title;
        
        Map.addAnnotation(annotation);
    }
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.view.addGestureRecognizer(longPressRecognizer)

        weather =  WeatherGetter(delegate: self)
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "Museum")
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try appDelegate.persistentContainer.viewContext.execute(DelAllReqVar) }
        catch { print(error) }
            
        UserDefaults.standard.setValue(true, forKey: "DidSetup");
  
        var newObject = NSEntityDescription.insertNewObject(forEntityName: "Museum", into: appDelegate.persistentContainer.viewContext) as NSManagedObject;
         
        newObject.setValue("Maxim Bogdanovich Museum",     forKey:     "museum");
        newObject.setValue("Grodno, st. May 1, 10",     forKey:     "address");
        newObject.setValue("Love in the life and work of M. Bogdanovich, Hrodna period of M.Bahdanovich's life",     forKey:     "exhibitions");
        newObject.setValue(23.83855936641433,     forKey:     "longitude");
        newObject.setValue(53.68738610520191,     forKey:     "latitude");
        
        newObject = NSEntityDescription.insertNewObject(forEntityName: "Museum", into: appDelegate.persistentContainer.viewContext) as NSManagedObject ;
                 
        newObject.setValue("Old Castle",     forKey:     "museum");
        newObject.setValue("Grodno, st. Zamkovaya, 22",     forKey:     "address");
        newObject.setValue("Overview of the royal palace",     forKey:     "exhibitions");
        newObject.setValue(23.82364960807564,     forKey:     "longitude");
        newObject.setValue(53.67705036836233,     forKey:     "latitude");
        
        newObject = NSEntityDescription.insertNewObject(forEntityName: "Museum", into: appDelegate.persistentContainer.viewContext) as NSManagedObject ;
                 
        newObject.setValue("New Castle",     forKey:     "museum");
        newObject.setValue("Grodno, st. Zamkovaya, 20",     forKey:     "address");
        newObject.setValue("Archaeological exhibition of the 20th century, Neoclassicism of the 20th century",     forKey:     "exhibitions");
        newObject.setValue(23.825349207114044,     forKey:     "longitude");
        newObject.setValue(53.67611884019172,     forKey:     "latitude");
            
        try! appDelegate.persistentContainer.viewContext.save();
        
    }
}

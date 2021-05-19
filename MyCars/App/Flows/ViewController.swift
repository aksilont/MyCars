//
//  ViewController.swift
//  MyCars
//
//  Created by Aksilont on 19.05.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context: NSManagedObjectContext!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lastTimeStartedLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromFile()
    }

    func getDataFromFile() {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mark != nil")
        
        var records = 0
        
        do {
            let count = try context.count(for: fetchRequest)
            records = count
            print("Data is there already")
        } catch {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        if let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: pathToFile),
           let initialData = try? PropertyListDecoder().decode([InitialData].self, from: xml) {
            initialData.forEach { item in
                let newCar = Car(context: context)
                newCar.mark = item.mark
                newCar.model = item.model
                newCar.rating = item.rating
                newCar.lastStarted = item.lastStarted
                newCar.timesDriven = item.timesDriven
                newCar.myChoice = item.myChoice
                newCar.imageData = UIImage(named: item.imageName)?.pngData()
                newCar.tintColor = UIColor(red: CGFloat(item.tintColor.red) / 255,
                                           green: CGFloat(item.tintColor.green) / 255,
                                           blue: CGFloat(item.tintColor.blue) / 255,
                                           alpha: 1.0)
            }
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
      
    }
    
    @IBAction func startEnginePressed(_ sender: UIButton) {
      
    }
    
    @IBAction func rateItPressed(_ sender: UIButton) {
      
    }
    
}

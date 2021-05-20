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
    var selectedCar: Car!
    
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
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: 0)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let result = try context.fetch(fetchRequest)
            selectedCar = result[0]
            insertDataFrom(selecredCar: selectedCar)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func insertDataFrom(selecredCar: Car) {
        carImageView.image = UIImage(data: selectedCar.imageData!)
        markLabel.text = selectedCar.mark
        modelLabel.text = selectedCar.model
        myChoiceImageView.isHidden = !(selectedCar.myChoice)
        ratingLabel.text = "Rating: \(selectedCar.rating) / 10.0"
        numberOfTripsLabel.text = "Number of trips: \(selectedCar.timesDriven)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        lastTimeStartedLabel.text = "Last timestarted: \(dateFormatter.string(from: selectedCar.lastStarted!))"
        
        segmentedControl.selectedSegmentTintColor = selectedCar.tintColor
    }
    
    private func getDataFromFile() {
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
        let mark = sender.titleForSegment(at: sender.selectedSegmentIndex)
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let results = try context.fetch(fetchRequest)
            selectedCar = results.first
            insertDataFrom(selecredCar: selectedCar)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func startEnginePressed(_ sender: UIButton) {
        selectedCar.timesDriven += 1
        selectedCar.lastStarted = Date()
        
        do {
            try context.save()
            insertDataFrom(selecredCar: selectedCar)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func rateItPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Rate it",
                                                message: "Rate this car please",
                                                preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.keyboardType = .decimalPad
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let textField = alertController.textFields?[0]
            self.update(rating: textField?.text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func update(rating: String?) {
        guard let rating = rating,
              let ratingDouble = Double(rating)
        else { return }
        selectedCar.rating = ratingDouble
        
        do {
            try context.save()
            insertDataFrom(selecredCar: selectedCar)
        } catch {
            let alertCotroller = UIAlertController(title: "Wrong value", message: "Worng input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertCotroller.addAction(okAction)
            present(alertCotroller, animated: true, completion: nil)
            print(error.localizedDescription)
        }
    }
    
}

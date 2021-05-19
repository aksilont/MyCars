//
//  ViewController.swift
//  MyCars
//
//  Created by Aksilont on 19.05.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    lazy var context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }()
    
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
    }

    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
      
    }
    
    @IBAction func startEnginePressed(_ sender: UIButton) {
      
    }
    
    @IBAction func rateItPressed(_ sender: UIButton) {
      
    }
    
}

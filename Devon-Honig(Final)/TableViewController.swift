//
//  TableViewController.swift
//  Devon-Honig(Final)
//
//  Created by Devon Honig on 4/4/18.
//  Copyright © 2018 Devon Honig. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var pairs: [Pair] = []
    let dateFormatter = DateFormatter()
    var pairIndex: Int = 0
    let defaultImage = UIImage(named: "defaultSneaker.jpg")
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        /*let newPair = Pair()
        newPair.brandName = "Nike"
        newPair.price = 180.00
        newPair.styleName = "AirMax One"
        
        pairs.append(newPair)*/
        
        fetchTrips()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Writes image to file and returns unique file name (From Homework 5 sample solution)
    func writeImageToFile(_ image: UIImage) -> String? {
        if let data = UIImagePNGRepresentation(image) {
            if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let uniqueId = UUID().uuidString
                let fileName = "\(uniqueId).png"
                let fileURL = directoryURL.appendingPathComponent(fileName)
                do {
                    try data.write(to: fileURL)
                    return fileName
                } catch {
                    print("\(error)")
                }
            }
        } else {
            print("Error converting image to PNG")
        }
        return nil
    }
    
    func readImageFromFile(_ fileName: String) -> UIImage? {
        if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directoryURL.appendingPathComponent(fileName)
            return UIImage(contentsOfFile: fileURL.path)
        }
        return nil
    }
    
    func deleteImageFile(_ fileName: String) {
        if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directoryURL.appendingPathComponent(fileName)
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("\(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pairs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paircell", for: indexPath) as! pairCell
        let pair = pairs[indexPath.row]
        cell.brandLabel.text = pair.brandName
        cell.styleLabel.text = pair.styleName
        if let imageFileName = pair.imageFileName {
            if let image = readImageFromFile(imageFileName) {
                cell.pairImageView.image = image
            } else {
                cell.pairImageView.image = defaultImage
            }
        } else {
            cell.pairImageView.image = defaultImage
        }
        return cell
    }
    
    @IBAction func addPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAddPair", sender: self)
    }
    
    
    @IBAction func unwindFromAddPair(sender: UIStoryboardSegue) {
        let addPairVC = sender.source as! ViewController
        if (!addPairVC.cancelled) {
            let pair = NSEntityDescription.insertNewObject(forEntityName: "PairEntity", into: self.managedObjectContext)
            let pairObj = Pair()
            let brandName = addPairVC.brandTextField.text!
            let styleName = addPairVC.styleTextField.text!
            let price = (addPairVC.priceTextField.text! as NSString).doubleValue
            let image = writeImageToFile(addPairVC.pairImageView.image!)
            
            pair.setValue(brandName, forKey: "brandName")
            pair.setValue(styleName, forKey: "styleName")
            pair.setValue(price, forKey: "price")
            pair.setValue(image, forKey: "imageFileName")
            self.appDelegate.saveContext()
            
            pairObj.brandName = brandName
            pairObj.styleName = styleName
            pairObj.price = price
            pairObj.imageFileName = image
            pairs.append(pairObj)
            self.tableView.reloadData()
            
            /*let pair = Pair()
            pair.brandName = addPairVC.brandTextField.text!
            pair.styleName = addPairVC.styleTextField.text!
            pair.price = (addPairVC.priceTextField.text! as NSString).doubleValue
            pair.imageFileName = writeImageToFile(addPairVC.pairImageView.image!)
            pairs.append(pair)
            self.tableView.reloadData()*/
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pairIndex = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let detailVC = segue.destination as! detailedView
            detailVC.selectedPair = pairs[pairIndex]
        }
    }
    
    func fetchTrips() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PairEntity")
        var pairEntities: [NSManagedObject]!
        
        do {
            pairEntities = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error getting trips within 'fetchTrips'")
        }
        
        print("Found \(pairEntities.count) trips.")
        for i in pairEntities {
            let newPair = Pair()
            
            newPair.brandName = i.value(forKey: "brandName") as! String
            newPair.styleName = i.value(forKey: "styleName") as! String
            newPair.price = i.value(forKey: "price") as! Double
            newPair.imageFileName = i.value(forKey: "imageFileName") as? String
            
            pairs.append(newPair)
        }
        
        self.tableView.reloadData()
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

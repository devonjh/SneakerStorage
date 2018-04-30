//
//  detailedView.swift
//  Devon-Honig(Final)
//
//  Created by Devon Honig on 4/29/18.
//  Copyright © 2018 Devon Honig. All rights reserved.
//

import UIKit

class detailedView: UIViewController {
    
    var selectedPair: Pair!
    let dateFormatter = DateFormatter()
    let defaultImage = UIImage(named: "defaultSneaker.jpg")
    
    @IBOutlet weak var pairImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIApplication.shared.open(URL(string: "http://www.twitter.com/thatkiddevon_1")!, options: [:])
        
        brandLabel.text = "Brand: \(selectedPair.brandName)"
        styleLabel.text = "Style: \(selectedPair.styleName)"
        priceLabel.text = "Price: \(selectedPair.price)"
        if let imageFileName = selectedPair.imageFileName {
            if let image = readImageFromFile(imageFileName) {
                pairImageView.image = image
            } else {
                pairImageView.image = defaultImage
            }
        } else {
            pairImageView.image = defaultImage
        }

        // Do any additional setup after loading the view.
    }
    
    func readImageFromFile(_ fileName: String) -> UIImage? {
        if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directoryURL.appendingPathComponent(fileName)
            return UIImage(contentsOfFile: fileURL.path)
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

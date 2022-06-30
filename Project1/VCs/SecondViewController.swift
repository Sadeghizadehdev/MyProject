//
//  SecondViewController.swift
//  Project1
//
//  Created by Alrzbod on 6/24/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var isPublicLabel: UILabel!
    
    var ispublic : String = ""
    var photoTitle : String = ""
    var width : String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(ispublic)
        print(photoTitle)
        print(widthLabel)
        
        
        titleLabel.text = photoTitle
        isPublicLabel.text = ispublic
        widthLabel.text = width
        //configure photo information Label
        
        
        if ispublic == "1" {
            
            isPublicLabel.text = "Yes"
            
         } else {
             
            isPublicLabel.text = "NO"
     }
    }
    //configure isPublic Prpperty
    
    
    
    @IBAction func ByClickBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        //configure Back Button
    }
    
}

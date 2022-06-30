//
//  PhotoViewCell.swift
//  Project1
//
//  Created by Alrzbod on 6/24/22.
//

import UIKit
import Kingfisher

class PhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!   
    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var photoSubTitle: UILabel!
    
    @IBOutlet weak var ByClick: UIButton!
    
    @IBAction func ClickButton(_ sender: Any) {
        
    

    }
    
    var imageURL : String? {
        
    didSet {
        if let imageURL = imageURL, let url = URL(string: imageURL) {
         photoImageView.kf.setImage(with: url)
        } else {
       photoImageView.image = nil
       photoImageView.kf.cancelDownloadTask()
        }
        
    }
        
        //configure Photo & collection View
}
     
     override func prepareForReuse(){
     
        super.prepareForReuse()
         imageURL = nil
     }
    
     


  
}

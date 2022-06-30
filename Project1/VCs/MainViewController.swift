//
//  MainViewController.swift
//  Project1
//
//  Created by Alrzbod on 6/23/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class MainViewController: UIViewController {

    var ispublic: [String] = []
    var widths : [String] = []
    var titles : [String] = []
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var photos : [Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         call main function for
         Fetch and setup Data
        */

        fetchFlickrPhotos() { photos in
            print(self.photos)
            self.getFlichrPhotos()
        }
       
        
         }
   
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cell = sender as? PhotoViewCell{
        let indexPath = self.collectionVIew.indexPath(for: cell)

        let vc = segue.destination as! SecondViewController
                
            vc.photoTitle = titles[indexPath!.row]
            vc.width = widths[indexPath!.row]
            vc.ispublic = ispublic[indexPath!.row]
         
        }
        // initial & send data to second page with UIStoryboardSegue
    }
    

}

//collection view setup
extension MainViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
     }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoViewCell
        
        let photo = photos[indexPath.row]
        cell.imageURL = photo.smallImageURL
        cell.photoTitle.text = titles[indexPath.row]
       
        
        return cell
    }
}




 extension MainViewController {
     
     func getFlichrPhotos(searchText: String? = nil){
         MBProgressHUD.showAdded(to: view, animated: true)
                 
         fetchFlickrPhotos(searchText: searchText) { [weak self] (photos) in
             guard let strongSelf = self  else  {return}
             MBProgressHUD.hide(for: strongSelf.view, animated: true)
               
             
             if let photos = photos {
                 strongSelf.photos = photos
                 strongSelf.collectionVIew.reloadData()
                 
                
             }
             
         }
     }
    
     
     
   //networking & reaload Data
 func fetchFlickrPhotos(searchText: String? = nil, completion: (([Photo]?) -> Void)? = nil) {
  
    // Url Creat
 let endpoint = MainUrlCreat(url: "rest/")
 
   
     
     //set parameters
 let url = URL(string: endpoint)!
     var parameters = [
 "method" : "flickr.interestingness.getList" ,
 "api_key" : "0b7ef5db6ab47c28a8ec220c84d1189e" ,
 "sort": "relevance",
 "per_page" : "100000",
 "format" : "json",
 "nojsoncallback" : "1",
 "extras": "url_q,url_z"
 ]
 
     
     
     
    if let searchText = searchText {
        
        //configure search Bar
        parameters["method"] = "flickr.photos.search"
        parameters["text"] = searchText
      
     }
     
     
    //configure request with POST
    //Alamofire.request(url, method:.put, parameters: parameters) For PUT
     
    Alamofire.request(url, method:.post, parameters: parameters)
        .validate()
        .responseData { [self]  (response) in
         switch response.result {
         case .success:
            guard let data = response.data, let json = try? JSON(data : data) else {
                
            print("error while parsing")
            completion?(nil)
            return
            }
             
            print(json)
             
             
             //fetch data From Server with Json Key
             let photosJSON = json["photos"]["photo"]
             let  photos = photosJSON.arrayValue.compactMap { Photo(json: $0) }
             
             self.titles = json["photos"]["photo"].arrayValue.map {$0["title"].stringValue}
             self.ispublic = json["photos"]["photo"].arrayValue.map {$0["ispublic"].stringValue}
             self.widths = json["photos"]["photo"].arrayValue.map {$0["width_z"].stringValue}
             
             print("widths is : \(self.widths)")
             print("titles is : \(self.titles)")
             print("owners is : \(self.ispublic)")
             
             completion?(photos)
            
          
             // error Handle
           case.failure(let error):
           print("Error while fetching photos: \(error.localizedDescription)")
           completion?(nil)
           
             
        }
       }
     }
    }
 


extension MainViewController : UISearchBarDelegate {
  
    //configure search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getFlichrPhotos(searchText: searchBar.text)
    }
       
}
 

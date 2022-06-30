//
//  ViewController.swift
//  StrAlberry Part 1
//
//  Created by Alrzbod on 6/23/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       GetData()
    }



   func GetData(){
       
    //configure request with GET
       
    let url = MainUrlCreat(url: "?method=flickr.cameras.getBrands&api_key=74f3b31c5f8ab3a6fd927846873a6e43&format=json&nojsoncallback=1&auth_token=72157720848074489-5c33be41a6914d4d&api_sig=35e382f7abd5650a2ed25b62c6e3a29a")
    //step 0 > creat url by MainUrlCreat function
       
    let request = Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
    //step 1 > creat a request
        
       
    request.responseJSON(completionHandler: { response in
    print("response from server is : \(response) \n")
    // step 2 > get Data From Server
        
    if let rawData = response.result.value {
                
    let json = JSON(rawData as! Dictionary<String , AnyObject>)
    // step 3 > creat Json Format from raw Data
       
    let codableName =  CodableAPI.init(brand: json["brands"]["brand"].arrayValue.map {$0["name"].stringValue},
    stat:  json["brands"]["brand"]["statt"].stringValue)
        
    let codableID = CodableAPI.init(brand: json["brands"]["brand"].arrayValue.map {$0["id"].stringValue},
        stat:  nil)
        
    let codableStatus = CodableAPI.init(brand: [nil] , stat: json["stat"].stringValue)
    // step 4 > fetch Data with key From json and convert to string and init by codable
        
    print("Codable Names is :\(codableName) \n")
    print("Codable IDs is :\(codableID) \n ")
    print("Codable status is :\(codableStatus) \n")
   
        
    } else  {
           
        print("Error!")
           
    }
        
     })

        }

             }


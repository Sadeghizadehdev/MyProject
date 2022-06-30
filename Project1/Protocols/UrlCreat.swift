//
//  UrlCreat.swift
//  StrAlberry Part 1
//
//  Created by Alrzbod on 6/23/22.
//

import Foundation



func MainUrlCreat(url : String) -> String {
    
   let baseEndpoint = "https://www.flickr.com/services/"
   // main flicker endpoint
    
   let mainURL = baseEndpoint + url
   //create main Url by attach base Endpoint & own url
    
   print("main URL is : \(mainURL)")
    
   return mainURL
      
}

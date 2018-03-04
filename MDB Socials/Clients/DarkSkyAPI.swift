//
//  DarkSkyAPI.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/3/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import Foundation
import Alamofire
let latitude =

let stringURL =  "https://api.darksky.net/forecast/50b32f864695d836f5360d46bdfb6a61/[latitude],[longitude]"



Alamofire.request("https://httpbin.org/get").responseJSON { response in
    print("Request: \(String(describing: response.request))")   // original url request
    print("Response: \(String(describing: response.response))") // http url response
    print("Result: \(response.result)")                         // response serialization result
    
    if let json = response.result.value {
        print("JSON: \(json)") // serialized json response
    }
    
    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print("Data: \(utf8Text)") // original server data as UTF8 string
    }
}

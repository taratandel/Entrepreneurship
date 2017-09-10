//
//  File.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/19/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class GettingDataWithAlamoFire {
    
    func registerTopStudentUser(url: String, completionHandler : @escaping (Informations?, Error?, Int?) -> () ){
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                if let jsonArray : NSDictionary = value as? NSDictionary {
                    let infos = Informations()
                    infos.activated = jsonArray["Activated"] as! Bool
                    infos.areaRank = jsonArray["AreaRank"] as? Int
                    infos.cityName = jsonArray["CityName"] as! String
                    infos.counter = jsonArray["Counter"] as! Int
                    infos.groupCode = jsonArray["GroupCode"] as! Int
                    infos.id = jsonArray["Id"] as! Int
                    infos.isBoorsieh = jsonArray["IsBoorsieh"] as! Bool
                    infos.kanoonYear = jsonArray["KanoonYear"] as? Int
                    infos.lastNmae = jsonArray["LastName"] as! String
                    infos.mobile = jsonArray["mobile"] as! String
                    infos.name = jsonArray["Name"] as! String
                    infos.sahmie = jsonArray["Sahmieh"] as? Int
                    infos.stateName = jsonArray["StateName"] as! String
                    infos.totalRank = jsonArray["TotalRank"] as? Int
                    infos.totalYearStudent = jsonArray["TotalYearStudent"] as! Int
                    completionHandler(infos, nil, nil)
                    
                }
                else if let jsonError :Int = value as? Int{
                   completionHandler(nil, nil, jsonError)
                }
            case .failure(let error):
                completionHandler(nil, error, nil)
                
            }
        }
        
    }
    func activateUser(url: String, completionHandelr : @escaping (String?, Error?)->()){
        Alamofire.request(url).responseString{
            response in
            switch response.result{
            case .success(let value):
                let res :String = value
                completionHandelr(res, nil)
                
            case .failure(let error):
                completionHandelr(nil, error)
            }
        }
    }
    
    func sendSMS(url: String, parameters: Parameters, completionHandler : @escaping (String?, Error?) -> ()){
        Alamofire.request(url, method: .post, parameters: parameters).responseString{
            response in
            switch response.result{
            case .success(let value):
                if let code: String = value as? String{
                    completionHandler(code , nil)
                }
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }

}

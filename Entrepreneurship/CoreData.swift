//
//  CoreData.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/19/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataCalcs {
    func fetchFromCoreDate() -> Informations?{
        var useDatas = [NSManagedObject]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetching Datas
        
        let fechtRequest  = NSFetchRequest<NSManagedObject>(entityName: "UsersInfo")
        
        //check if data exists or not
        do {
            //if exists fill the array
            useDatas = try managedContext.fetch(fechtRequest)
            var useInfo = Informations()
            if useDatas.count > 0 {
            useInfo.activated = useDatas[0].value(forKey: "activated") as! Bool
            useInfo.areaRank = useDatas[0].value(forKey: "areaRank") as? Int
            useInfo.cityName = useDatas[0].value(forKey: "cityName") as! String
            useInfo.counter = useDatas[0].value(forKey: "counter") as! Int
            useInfo.groupCode = useDatas[0].value(forKey: "groupCode") as! Int
            useInfo.id = useDatas[0].value(forKey: "id") as! Int
            useInfo.isBoorsieh = useDatas[0].value(forKey: "isBoorsieh") as! Bool
            useInfo.kanoonYear = useDatas[0].value(forKey: "kanoonYear") as? Int
            useInfo.lastNmae = useDatas[0].value(forKey: "lastName") as! String
            useInfo.mobile = useDatas[0].value(forKey: "mobile") as! String
            useInfo.name = useDatas[0].value(forKey: "name") as! String
            useInfo.sahmie = useDatas[0].value(forKey: "sahmie") as? Int
            useInfo.stateName = useDatas[0].value(forKey: "stateName") as! String
            useInfo.totalRank = useDatas[0].value(forKey: "totalRank") as? Int
            useInfo.totalYearStudent = useDatas[0].value(forKey: "totalYearStudent") as! Int
            
        return useInfo
            }
            else {
                return nil
            }
        }
        catch let error as NSError {
            //if not shows the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }

    
    }
    func saveToCoreData(info : Informations) -> Bool{
        var useDatas = [NSManagedObject]()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName:"UsersInfo",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        person.setValue(info.activated , forKeyPath: "activated")
        person.setValue(info.cityName, forKey: "cityName")
        person.setValue(info.counter, forKey: "counter")
        person.setValue(info.groupCode, forKey: "groupCode")
        person.setValue(info.id, forKey: "id")
        person.setValue(info.isBoorsieh, forKey: "isBoorsieh")
        person.setValue(info.lastNmae, forKey: "lastName")
        person.setValue(info.mobile, forKey: "mobile")
        person.setValue(info.name, forKey: "name")
        person.setValue(info.stateName, forKey: "stateName")
        person.setValue(info.totalYearStudent, forKey: "totalYearStudent")
        if info.sahmie != 0 && info.areaRank != 0 && info.kanoonYear != 0 && info.totalRank != 0 {
        person.setValue(info.sahmie, forKey: "sahmie")
        person.setValue(info.kanoonYear, forKey: "kanoonYear")
        person.setValue(info.totalRank, forKey: "totalRank")
        person.setValue(info.areaRank, forKey: "areaRank")
        }
        else {
            
            
        }


        
        
        // 4
        do {
            try managedContext.save()
            useDatas.append(person)
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        
    }
    func saveOtherToTheCoreData(newInfo : Informations , pastInfo : Informations) -> Bool {
        self.deleteCoreData()
        var useDatas = [NSManagedObject]()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName:"UsersInfo",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        person.setValue(pastInfo.activated , forKeyPath: "activated")
        person.setValue(pastInfo.cityName, forKey: "cityName")
        person.setValue(pastInfo.counter, forKey: "counter")
        person.setValue(pastInfo.groupCode, forKey: "groupCode")
        person.setValue(pastInfo.id, forKey: "id")
        person.setValue(pastInfo.isBoorsieh, forKey: "isBoorsieh")
        person.setValue(pastInfo.lastNmae, forKey: "lastName")
        person.setValue(pastInfo.mobile, forKey: "mobile")
        person.setValue(pastInfo.name, forKey: "name")
        person.setValue(pastInfo.stateName, forKey: "stateName")
        person.setValue(pastInfo.totalYearStudent, forKey: "totalYearStudent")
            person.setValue(newInfo.sahmie, forKey: "sahmie")
            person.setValue(newInfo.kanoonYear, forKey: "kanoonYear")
            person.setValue(newInfo.totalRank, forKey: "totalRank")
            person.setValue(newInfo.areaRank, forKey: "areaRank")
 
        
        
        
        
        // 4
        do {
            try managedContext.save()
            useDatas.append(person)
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        
    }
    func deleteCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetching Datas
        
        let fechtRequest  = NSFetchRequest<NSManagedObject>(entityName: "UsersInfo")
        
        //check if data exists or not
        do {
            //if exists fill the array
            let nationalCode = try managedContext.fetch(fechtRequest)
            for managedObject in nationalCode
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in IsLoggedIn error : \(error) \(error.userInfo)")
        }
        
    

    }
}

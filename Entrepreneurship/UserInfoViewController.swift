//
//  UserInfoViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/19/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit
import CoreData

class UserInfoViewController: UIViewController {

    @IBOutlet weak var usInf7: UILabel!
    @IBOutlet weak var usInf6: UILabel!
    @IBOutlet weak var usInf5: UILabel!
    @IBOutlet weak var usInf4: UILabel!
    @IBOutlet weak var usInf3: UILabel!
    @IBOutlet weak var usInf2: UILabel!
    @IBOutlet weak var usInf1: UILabel!
    @IBOutlet weak var usInf: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDatas()
        usInf?.text = "اطلاعات شخصی"
        seetinginitials()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func settingDatas (){
        let getInfo = CoreDataCalcs()
        let infos = getInfo.fetchFromCoreDate()
        usInf1?.text = (infos?.name)! + (infos?.lastNmae)!
        usInf2?.text = gPCodeToName(gpcode: (infos?.groupCode)!)
        usInf3?.text = "\((infos?.counter)!)"
        usInf4?.text = "سابقه کانونی" + "\((infos?.totalYearStudent)!)" + "سال"
        if (infos?.isBoorsieh)! {
            usInf5?.text = "بورسیه"
        }
        else if !(infos?.isBoorsieh)! {
            usInf5?.text = "عادی"
            
        }
        usInf6?.text = infos?.stateName
        usInf7?.text = infos?.cityName
    
    
    }
    func gPCodeToName(gpcode : Int) -> String {
        let reshteCode = gpcode
        var reshteName = String()
        switch reshteCode {
        case 1:
            reshteName = "چهارم ریاضی"
        case 3:
            reshteName = "چهارم تجربی"
        case 5:
            reshteName = "چهارم انسانی"
        case 7:
            reshteName = "هنر"
        case 9:
            reshteName = "منحصرا زبان"
        case 21:
            reshteName = "سوم ریاضی"
        case 22:
            reshteName = "سوم تجربی"
        case 23:
            reshteName = "سوم انسانى"
        case 24:
            reshteName = "دهم ریاضی"
        case 25:
            reshteName = "دهم تجربی"
        case 26:
            reshteName = "دهم انسانی"
        case 27:
            reshteName = "نهم"
        case 31:
            reshteName = "هشتم"
        case 33:
            reshteName = "هفتم"
        case 35:
            reshteName = "ششم دبستان"
        case 41:
            reshteName = "پنجم دبستان"
        case 43:
            reshteName = "چهارم دبستان"
        case 45:
            reshteName = "سوم دبستان"
        case 46:
            reshteName = "دوم دبستان"
        case 47:
            reshteName = "اول دبستان"
        default:
            reshteName = ""
        }
        
        return reshteName
        
    }
    func seetinginitials(){
        //usInf.backgroundColor = .white
        usInf1.backgroundColor = .white
        usInf2.backgroundColor = .white
        usInf3.backgroundColor = .white
        usInf4.backgroundColor = .white
        usInf5.backgroundColor = .white
        usInf6.backgroundColor = .white
        usInf7.backgroundColor = .white
        usInf.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf1.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf3.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf2.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf4.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf5.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf6.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        usInf7.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)

    }
    @IBAction func exit(_ sender: Any) {
        
        performSegue(withIdentifier: "loggout", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loggout"{
            //preparing coredata
            let cod = CoreDataCalcs()
            let _ = cod.deleteCoreData()
        }
        
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

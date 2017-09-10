//
//  ViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/19/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftCop

class ViewController: UIViewController {
    
    @IBOutlet weak var phoneMessage: UILabel!
    @IBOutlet weak var counterMessage: UILabel!
    @IBOutlet weak var warning: UILabel!
    
    @IBOutlet weak var enter: UIButton!
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nationalNumberOrCounter: UITextField!
    
    let swiftCop = SwiftCop()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        enter.titleLabel?.text = "ورود"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        swiftCop.addSuspect(Suspect(view: self.phoneNumber, sentence: "شماره ۱۱ رقمی", trial: Trial.length(.is, 11)))
        swiftCop.addSuspect(Suspect(view: self.nationalNumberOrCounter, sentence: "شمارنده ۹ رقمی یا کد ملی ۱۰ رقمی", trial: Trial.length(.in, 9..<11 as Range)))
        phoneNumber.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1
        )
        phoneNumber.backgroundColor = .white
        nationalNumberOrCounter.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        nationalNumberOrCounter.backgroundColor = .white
        phoneMessage.textColor = .red
        counterMessage.textColor = .red
        warning.textColor = .red
        enter.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 10)
        //enter.backgroundColor = .yellow
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func validateCounter(_ sender: UITextField) {
        
        self.counterMessage.text = swiftCop.isGuilty(sender)?.verdict()
    }
    @IBAction func validatePhoneNumber(_ sender: UITextField) {
        
        self.phoneMessage.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    @IBAction func enter(_ sender: Any) {
        enter.titleLabel?.text = "ورود"
        if nationalNumberOrCounter.text?.characters.count == 10 && phoneNumber.text?.characters.count == 11{
            gettingInfo(CON: 1)
            
        }
        else if nationalNumberOrCounter.text?.characters.count == 9 && phoneNumber.text?.characters.count == 11{
            gettingInfo(CON: 2)
            
        }
        else{
            warning?.text = "اطلاعات ناقص است"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.warning?.text = ""
            }
        }
        
    }
    func gettingInfo(CON:Int){
        var smsresponse = String()
        var urlst = String()
        if CON == 1{
            urlst = "http://city.kanoon.ir/newsite/common/webservice/WsCityData.asmx/RegisterTopStudentUserByNationalForIos?nationalCode=\((nationalNumberOrCounter.text)!)&mobile=\((phoneNumber.text)!)"
        }
        else if CON == 2 {
            urlst = "http://city.kanoon.ir/newsite/common/webservice/WsCityData.asmx/RegisterTopStudentUserByCounterForIos?counter=\((nationalNumberOrCounter.text)!)&mobile=\((phoneNumber.text)!)"
            
        }
        let request = GettingDataWithAlamoFire()
        request.registerTopStudentUser(url: urlst){
            response , error , errorstr in
            if response != nil {
                if !(response?.activated)!{
                    let urlstr = "http://city.kanoon.ir/newsite/Common/WebService/WSCityData.asmx/SendActivationMessageToPlayerForIos"
                    let parameteres = ["mobile" : "\((self.phoneNumber.text)!)" , "key" : "g0L3sT4nT34m"]
                    request.sendSMS(url: urlstr, parameters: parameteres){
                        smssresponse , error in
                        if smssresponse != nil{
                            smsresponse = smssresponse!
                        let alertController = UIAlertController(title: "ورود کد", message: "", preferredStyle: .alert)
                        
                        let saveAction = UIAlertAction(title: "ارسال دوباره", style: .default, handler: {
                            alert -> Void in
                            request.sendSMS(url: urlstr, parameters: parameteres){
                                smsResponse , error in
                                if response != nil {
                                    
                                    smsresponse = smsResponse!
                                    
                                }
                            }
                            
                            self.present(alertController, animated: true, completion: nil)
                        })
                        let cancelAction = UIAlertAction(title: "تایید", style: .default, handler: {
                            (action : UIAlertAction!) -> Void in
                            
                            let firstTextField = alertController.textFields![0] as UITextField
                            if firstTextField.text != ""{
                                if "\(smsresponse)" == (firstTextField.text)!{
                                    let urlst = "http://city.kanoon.ir/newsite/common/webservice/WsCityData.asmx/ActivateTopStudentUserForIos?id=\((response?.id)!)"
                                    request.activateUser(url: urlst){
                                        respo , errors in
                                        if respo != nil {
                                            if respo == "True"{
                                                let canSegue = CoreDataCalcs()
                                                if canSegue.saveToCoreData(info: response!){
                                                    self.performSegue(withIdentifier: "toTabs", sender: self)
                                                }
                                            }
                                            else {
                                                self.warning.text = ".شما فعال نشده اید لطفا اطلاعات را چک کرده و دوباره امتحان کنید"
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                    self.warning?.text = ""
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            else {
                                self.warning.text = "کد ارسالی صحیح نیست."
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                    self.warning?.text = ""
                                }
                                
                                
                            }
                            
                        })
                        alertController.addTextField { (textField : UITextField!) -> Void in
                            textField.placeholder = "کد ارسال شده را وارد کنید"
                        }
                        
                        alertController.addAction(saveAction)
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true, completion: nil)

                    }
                        else {
                            self.warning.text = "خطا در شبکه دوباره امتحان کنید."
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                self.warning?.text = ""
                            }
                        }

                    }

                    
                }
                else if (response?.activated)!{
                    let canSegue = CoreDataCalcs()
                    if canSegue.saveToCoreData(info: response!){
                        self.performSegue(withIdentifier: "toTabs", sender: self)
                    }
                }
            }
            else if errorstr != nil {
                self.warning?.text = "اطلاعات شما در سامانه وجود ندارد."
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.warning?.text = ""
                }
            }
            else if error != nil {
                self.warning?.text = ".خطا در شبکه دوباره امتحان کنید"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.warning?.text = ""
                }
                self.enter.titleLabel?.text = "تلاش دوباره"
            }
        }
    }
}


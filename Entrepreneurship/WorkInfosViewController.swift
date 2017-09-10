//
//  WorkInfosViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/22/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit
import SwiftCop

class WorkInfosViewController: UIViewController, UIPopoverPresentationControllerDelegate, SectionSelectionTableViewControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var overallRankText: UITextField!
    @IBOutlet weak var areaRankText: UITextField!
    @IBOutlet weak var areaText: UITextField!
    @IBOutlet weak var konkoorYearText: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var konkoorYear: UILabel!
    @IBOutlet weak var round2: UILabel!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var round1: UILabel!
    @IBOutlet weak var overallRank: UILabel!
    @IBOutlet weak var areaRank: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var emailValidationMessage: UILabel!
    
    @IBOutlet weak var expSwitch: UISwitch!
    @IBOutlet weak var bookSwitch: UISwitch!
    
    @IBOutlet weak var choose: UIButton!
    @IBOutlet weak var saveandwarn: UIButton!
    
    var examYear = Int()
    var bookUse : Bool = true
    var havEXP : Bool = true
    var selectedIndexPathses = [Int]()
    
    //var section = String()
    
    let swiftCOP = SwiftCop()
    let coredata = CoreDataCalcs()
    let sections = ["پشتیبان ویژه","تولید آزمون","تولید محتوا","مستند سازی","فعالیت های اجرایی"]
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        settingLables(usInfo: (coredata.fetchFromCoreDate())!)
        makingThemRound()
        swiftCOP.addSuspect(Suspect(view: email, sentence: " ایمیل معتبر به صورت انگلیسی و بدون http  ", trial: Trial.email))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func bookUsed(_ sender: Any) {
        if bookSwitch.isOn {
            bookUse = false
            bookSwitch.setOn(false, animated: true)
        }
            
        else {
            bookUse = true
            bookSwitch.setOn(true, animated: true)
        }
    }
    @IBAction func haveExp(_ sender: Any) {
        if expSwitch.isOn{
            havEXP = false
            expSwitch.setOn(false, animated: true)
        }
        else {
            havEXP = true
            expSwitch.setOn(true, animated: true)
        }
    }
    @IBAction func emailEntery(_ sender: UITextField) {
        self.emailValidationMessage?.text = swiftCOP.isGuilty(sender)?.verdict()
        self.emailValidationMessage?.textColor = .red
    }
    func settingLables(usInfo : Informations){
        if usInfo.sahmie != 0 {
            areaText.isHidden = true
            areaRankText.isHidden = true
            overallRankText.isHidden = true
            konkoorYearText.isHidden = true
            area?.text = "\((usInfo.sahmie)!)"
            areaRank?.text = "\((usInfo.areaRank)!)"
            overallRank?.text = "\((usInfo.totalRank)!)"
            konkoorYear?.text = "\((usInfo.kanoonYear)!)"
        }
        else {
            area.isHidden = true
            areaRank.isHidden = true
            overallRank.isHidden = true
            konkoorYear.isHidden = true
        }
    }
    func makingThemRound(){
        
        email.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        konkoorYear.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        overallRank.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        areaRank.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        area.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        saveandwarn.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        choose.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        round1.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        round2.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        konkoorYearText.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        overallRankText.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        areaRankText.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        areaText.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        
        
        
        
    }
    @IBAction func selectSections(_ sender: Any) {
        performSegue(withIdentifier: "pop", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop"{
            let dest = segue.destination as! SectionSelectionTableViewController
            if let pop = dest.popoverPresentationController{
                pop.delegate = self
                dest.delegates = self
                dest.sections = self.sections
            }
            
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func saveIndex(indexes : [Int])
    {
        self.selectedIndexPathses = indexes
        if selectedIndexPathses.count > 0 {
            choose.setTitle("\(selectedIndexPathses.count)" + " مورد ", for: .normal)
        }
        else if selectedIndexPathses.count == 0{
            choose.setTitle("انتخاب کنید", for: .normal)
        }
        print(selectedIndexPathses)
    }
    @IBAction func sendInfo(_ sender: Any) {
        showAlertBeforSaving()
        
    }
    func sendin (){
        
        saveandwarn.setTitle("ثبت", for: .normal)
        if selectedIndexPathses.count > 0 && (email.text?.characters.count)!>0{
            var urls = String()
            let id = (coredata.fetchFromCoreDate()?.id)!
            if !konkoorYear.isHidden {
                urls = "http://city.kanoon.ir/newsite/common/webservice/WsCityData.asmx/SaveTopStudentJobInfoForIos?id=\(id)&year=\((konkoorYear.text)!)&email=\((email.text)!)&isBookUsed=\(bookUse)&isAlreadyWorkedInKanoon=\(havEXP)&workingSection=\(transferArrayToString(array: selectedIndexPathses))"
            }
            else if konkoorYear.isHidden {
                urls = "http://city.kanoon.ir/newsite/common/webservice/WsCityData.asmx/SaveTopStudentJobInfo2ForIos?id=\(id)&year=\((konkoorYearText.text)!)&email=\((email.text)!)&isBookUsed=\(bookUse)&isAlreadyWorkedInKanoon=\(havEXP)&workingSection=\(transferArrayToString(array: selectedIndexPathses))&totalRank=\((overallRankText.text)!)&sahmieh=\((areaText.text)!)&areaRank=\((areaRankText.text)!)"
                let newlyAddedInfo =  Informations ()
                if ((areaRankText.text?.characters.count)! > 0 && konkoorYearText.text?.characters.count == 2 ){
                    newlyAddedInfo.areaRank = Int((areaRankText.text)!)
                    newlyAddedInfo.kanoonYear = Int((konkoorYearText.text)!)
                }
                else {
                    urls = ""
                }
                if (areaText.text?.characters.count)! == 1 && (overallRankText.text?.characters.count)! > 0 {
                    newlyAddedInfo.sahmie = Int((areaText.text)!)
                    newlyAddedInfo.totalRank = Int((overallRankText.text)!)
                }
                else {
                    urls = ""
                }
                
                if urls != "" {
                    let pastData = (coredata.fetchFromCoreDate())!
                    let _ = coredata.saveOtherToTheCoreData(newInfo: newlyAddedInfo , pastInfo : pastData)
                }
            }
            if urls != "" {
                let alamofiredata = GettingDataWithAlamoFire()
                alamofiredata.activateUser(url: urls){
                    
                    response , error in
                    
                    if response != "1" && response != "-5"{
                        
                        self.warning?.text = "خطایی رخ داده دوباره امتحان کنید"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            self.warning?.text = ""
                        }
                        
                        self.saveandwarn.setTitle("تلاش دوباره", for: .normal)
                    }
                        
                    else if response == "-5" {
                        self.warning?.text = "شما قبلا اطلاعات خود را ثبت کرده اید"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            self.warning?.text = ""
                        }
                        
                    }
                    else if response == "1"{
                        self.warning?.text = "ثبت شد"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5){
                            self.warning?.text = ""
                        }
                        self.overallRankText.isUserInteractionEnabled = false
                        self.areaRankText.isUserInteractionEnabled = false
                        self.areaText.isUserInteractionEnabled = false
                        self.konkoorYearText.isUserInteractionEnabled = false
                        self.email.isUserInteractionEnabled = false
                        self.selectedIndexPathses = []
                        self.choose.setTitle("انتخاب کنید", for: .normal)
                        
                    }
                    
                }
            }
            else {
                warning.text = "لطفا فیلد ها را به صورت گفته شده پر کنید."
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.warning?.text = ""
                }
            }
        }
        else {
            warning.text = "لطفا تمامی موارد را پر کنید."
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.warning?.text = ""
            }
            
            choose.setTitle("انتخاب کنید", for: .normal)
        }
    
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! + string)
        if str.characters.count <= 2 {
            return true
        }
        textField.text = str.substring(to: str.index(str.startIndex, offsetBy: 2))
        return false
    }
    
    func transferArrayToString(array : [Int]) -> String{
        var str = String()
        for i in 0..<array.count {
            str.append("\((array[i] + 1))" + ",")
        }
        return str
    }
    func showAlertBeforSaving () {
        let alertC = UIAlertController(title: "تایید اطلاعات", message: "آیا اطلاعات وارد شده را تایید میکنید؟", preferredStyle: .alert)
        let sendAction = UIAlertAction(title: "تایید", style: .destructive , handler :{ (alert) -> Void in
            self.sendin()
        })
        let cancelAction = UIAlertAction(title: "لغو", style: .cancel, handler:{
            (action : UIAlertAction!) -> Void in
            
        })
        alertC.addAction(sendAction)
        alertC.addAction(cancelAction)
        present(alertC, animated: true, completion: nil)
    }
    
}
protocol SectionSelectionTableViewControllerDelegate: class {
    func saveIndex(indexes : [Int])
}

//
//  jobIntroductionViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/22/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit



class jobIntroductionViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var b62: UIButton!
    @IBOutlet weak var b61: UIButton!
    @IBOutlet weak var b52: UIButton!
    @IBOutlet weak var b51: UIButton!
    @IBOutlet weak var b42: UIButton!
    @IBOutlet weak var b41: UIButton!
    @IBOutlet weak var b32: UIButton!
    @IBOutlet weak var b31: UIButton!
    @IBOutlet weak var b22: UIButton!
    @IBOutlet weak var b21: UIButton!
    @IBOutlet weak var b12: UIButton!
    @IBOutlet weak var b11: UIButton!
   
    @IBOutlet weak var n6: UILabel!
    @IBOutlet weak var n5: UILabel!
    @IBOutlet weak var n4: UILabel!
    @IBOutlet weak var n3: UILabel!
    @IBOutlet weak var n2: UILabel!
    @IBOutlet weak var n1: UILabel!
    
    var url = String()
    var labelname = String()
    var audiotriggerd = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        audiotriggerd = false
       // rounding()
        n1?.text = "پشتیبان ویژه:"
        n2?.text = "تولید آزمون:"
        n3?.text = "تولید محتوا:"
        n4?.text = "مستند سازی:"
        n5?.text = "فعالیت های اجرایی:"
        
       // n6?.text = "اجرایی"

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        audiotriggerd = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        audiotriggerd = false


    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
 

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func b11a(_ sender: Any) {
        url = "http://amoozesh.kanoon.ir/Files/karafarini/pdf/poshtiban-vije.pdf"
        performSegue(withIdentifier: "webView", sender: self)
        
    }
    @IBAction func b12a(_ sender: Any) {
        
        url = "http://amoozesh.kanoon.ir/files/karafarini/audio/poshtiban-vije.mp3"
        audiotriggerd = true
        labelname = (n1.text)!
        performSegue(withIdentifier: "audiopo", sender: self)

        
    }
    @IBAction func b21a(_ sender: Any) {
        url = "http://amoozesh.kanoon.ir/Files/karafarini/pdf/tolid-azmoon.pdf"
        performSegue(withIdentifier: "webView", sender: self)

        
    }
    @IBAction func b22a(_ sender: Any) {
        
        url = "http://amoozesh.kanoon.ir/files/karafarini/audio/tolid-azmoon.mp3"
        audiotriggerd = true

        labelname = (n2.text)!

        performSegue(withIdentifier: "audiopo", sender: self)

        
    }
    @IBAction func b31a(_ sender: Any) {
        url = "http://amoozesh.kanoon.ir/Files/karafarini/pdf/tolid-mohtava.pdf"
        performSegue(withIdentifier: "webView", sender: self)

        
    }
    @IBAction func b32a(_ sender: Any) {
        url = "http://amoozesh.kanoon.ir/files/karafarini/audio/tolid-mohtava.mp3"
        audiotriggerd = true

        labelname = (n3.text)!

        performSegue(withIdentifier: "audiopo", sender: self)

    }
    @IBAction func b42a(_ sender: Any) {
        url = "http://amoozesh.kanoon.ir/files/karafarini/audio/mostanad-sazi.mp3"
        audiotriggerd = true

        labelname = (n4.text)!
        
        performSegue(withIdentifier: "audiopo", sender: self)

        
    }
    @IBAction func b41a(_ sender: Any) {

        url = "http://amoozesh.kanoon.ir/Files/karafarini/pdf/mostanadsazi.pdf"
        performSegue(withIdentifier: "webView", sender: self)

        
    }
    @IBAction func b51a(_ sender: Any) {
        
        url = "http://amoozesh.kanoon.ir/Files/karafarini/pdf/Ejraee.pdf"
        performSegue(withIdentifier: "webView", sender: self)

        
    }
    @IBAction func b52a(_ sender: Any) {
        url = "http://amoozesh.kanoon.ir/files/karafarini/audio/ejraee.mp3"
        audiotriggerd = true

        labelname = (n5.text)!

        performSegue(withIdentifier: "audiopo", sender: self)

        
    }
   // @IBAction func b61a(_ sender: Any) {
        
    //}
   // @IBAction func b62a(_ sender: Any) {
        
   // }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webView"{
            let pdfView = segue.destination as! PDFViewViewController
            pdfView.url = self.url
            
            
        }
        if segue.identifier == "audiopo"{
            let audioplay = segue.destination as! AudioViewController
            if let pop = audioplay.popoverPresentationController{
                pop.delegate = self
            audioplay.urls = self.url
            audioplay.audioLabel = self.labelname  + "آشنایی با واحد"
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func rounding(){
        n1.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        n1.backgroundColor = .white
        n2.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        n2.backgroundColor = .white
        n3.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        n3.backgroundColor = .white
        n4.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        n4.backgroundColor = .white
        n5.fullyRound(diameter: 10, borderColor: .gray, borderWidth: 1)
        n5.backgroundColor = .white
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

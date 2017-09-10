//
//  LogginCheckViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/19/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit

class LogginCheckViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let logginCheck = CoreDataCalcs()
        if logginCheck.fetchFromCoreDate() != nil{
            performSegue(withIdentifier: "userLoggedIn", sender: self)
        }
        else {
            performSegue(withIdentifier: "useNotLoggedIn", sender: self)
        }
        
        // Do any additional setup after loading the view.

    }

    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

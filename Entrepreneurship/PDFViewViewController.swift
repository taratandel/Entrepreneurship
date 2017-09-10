//
//  PDFViewViewController.swift
//  Entrepreneurship
//
//  Created by Tara Tandel on 5/23/1396 AP.
//  Copyright © 1396 Tara Tandel. All rights reserved.
//

import UIKit

class PDFViewViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    var url = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlstr : URL! = URL(string: url)
        webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        view.addSubview(webView)
        webView.loadRequest(URLRequest(url: urlstr))
        self.navigationController?.navigationBar.isHidden = false

        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(shareTapped))
        
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
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

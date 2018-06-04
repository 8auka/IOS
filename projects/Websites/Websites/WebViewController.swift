//
//  WebViewController.swift
//  Websites
//
//  Created by Bauyrzhan on 23.02.17.
//  Copyright © 2017 Bauyrzhan. All rights reserved.
//

import UIKit

class WebViewController: ViewController {

    @IBOutlet weak var webLabel: UILabel!
    @IBOutlet weak var myWebView: UIWebView!
    
    var view_protocol : ViewController?
    var webView_url : String?
    var webView_title : String?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (webView_url != nil)
        {
            let url = URL(string: webView_url!)
            webLabel.text = webView_title
            myWebView.loadRequest(URLRequest(url: url!))
        }
        let tap_gesture = UITapGestureRecognizer(target: self, action: #selector(tap_happened))
        tap_gesture.numberOfTapsRequired = 3
        myWebView.addGestureRecognizer(tap_gesture)
    }
    
    func tap_happened() {
        view_protocol?.addFavourite(title : webView_title!, url: webView_url!)
        myWebView.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


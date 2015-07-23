//
//  AboutViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/14/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let htmlFile = NSBundle.mainBundle().pathForResource("aboutRoundTrip", ofType: "html") {
            let htmlData = NSData(contentsOfFile: htmlFile)
            let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
            webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

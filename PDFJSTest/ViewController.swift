//
//  ViewController.swift
//  PDFJSTest
//
//  Created by Vui Nguyen on 7/11/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

  //@IBOutlet weak var webView: UIWebView!
  var webView: WKWebView!

  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    // can we just make this a local URL (ie on my machine?)
    // or better yet, make it a URL to an opentextbook
    //let myURL = URL(string: "https://www.apple.com")

    //let myURL = URL(string: "http://localhost:8888")
    let urlString = "http://localhost:8888/web/viewer.html?file=%2Fexamples%2Fhelloworld%2FLinear%20Regression%20Using%20R-%20An%20Introduction%20to%20Data%20Modeling.pdf"

    //let urlString = "Linear Regression Using R- An Introduction to Data Modeling"
    /*
    guard let filePath = Bundle.main.path(forResource: urlString, ofType: "pdf")
      else {
        print("error getting filePath")
        return
    }
 */

    //let myURL = URL(string: "http://localhost:8888/examples/helloworld/")
    if let myURL = URL(string: urlString) {
    //if let myURL = URL(fileURLWithPath: filePath) {
    do {
    let myRequest = URLRequest(url: myURL)
    //webView.loadRequest(myRequest)  // to use with UIWebView

    //let data =  try Data(contentsOf: myURL)
    //webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: myURL.deletingLastPathComponent())


    webView.load(myRequest)
    }

    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


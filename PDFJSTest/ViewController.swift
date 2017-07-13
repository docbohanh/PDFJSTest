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

  var webView: WKWebView!

  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    renderLocalPDF()
    //renderServerPDF()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func renderLocalPDF() {
    let urlString = "Linear Regression Using R- An Introduction to Data Modeling"

    if let filePath = Bundle.main.path(forResource: urlString, ofType: "pdf") {
      do {
        let myURL = URL(fileURLWithPath: filePath)

        let myRequest = URLRequest(url: myURL)
        //webView.loadRequest(myRequest)  // to use with UIWebView

        //let data =  try Data(contentsOf: myURL)
        //webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: myURL.deletingLastPathComponent())

        
        webView.load(myRequest)
      }
      
    }
  }

  func renderServerPDF() {
    let urlString = "http://localhost:8888/web/viewer.html?file=%2Fexamples%2Fhelloworld%2FLinear%20Regression%20Using%20R-%20An%20Introduction%20to%20Data%20Modeling.pdf"

    if let myURL = URL(string: urlString) {

      let myRequest = URLRequest(url: myURL)

      webView.load(myRequest)
    }

  }


}


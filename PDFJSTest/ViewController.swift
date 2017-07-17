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
    //let urlString = "Linear Regression Using R- An Introduction to Data Modeling"
    //let urlString = "viewer"
    //let urlString = "generic/web/viewer"
    //let urlString = "examples/helloworld/index"
    let urlString = "build/generic/web/viewer"

  //let filePath = Bundle.main.resourceURL?.appendingPathComponent("generic/web/viewer.html").path
    //let filePath = Bundle.main.resourceURL?.appendingPathComponent("generic/web/Linear Regression Using R- An Introduction to Data Modeling.pdf").path
    //let filePath = Bundle.main.resourceURL?.appendingPathComponent("generic/web/compressed.tracemonkey-pldi-09.pdf").path
    // let filePath = Bundle.main.resourceURL?.appendingPathComponent("viewer.html").path
    //let filePath = Bundle.main.resourceURL?.appendingPathComponent("examples/helloworld/index.html").path
    let filePath = Bundle.main.resourceURL?.appendingPathComponent("build/generic/web/viewer.html").path
  print("File exists: \(FileManager().fileExists(atPath: filePath!))")


    //if let filePath = Bundle.main.path(forResource: urlString, ofType: "pdf") {
    //if let filePath = Bundle.main.path(forResource: urlString, ofType: "html", inDirectory: "generic/web") {
    if let filePath = Bundle.main.path(forResource: urlString, ofType: "html") {
      do {
        let myURL = URL(fileURLWithPath: filePath)

        let myRequest = URLRequest(url: myURL)

        webView.load(myRequest)
      }
    }
    else {
      print("cannot find resource")
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


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
  }

  func renderLocalPDF() {
    let urlString = "pdf.js-dist/web/viewer"

    let filePath = Bundle.main.resourceURL?.appendingPathComponent("pdf.js-dist/web/viewer.html").path
    print("File \(urlString).html exists: \(FileManager().fileExists(atPath: filePath!))")

    // first, load the PDF viewer
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

    // then, load the PDF into the viewer
    let timeDelay = 1.0 // in seconds
    Timer.scheduledTimer(timeInterval: timeDelay, target: self, selector: #selector(self.sendPDFData), userInfo: nil, repeats: false)
  }

  @objc func sendPDFData() {
    //let urlString = "compressed.tracemonkey-pldi-09"
    let urlString = "Linear Regression Using R- An Introduction to Data Modeling"

    if let filePath = Bundle.main.path(forResource: urlString, ofType: "pdf") {
      print("File \(urlString).pdf exists: \(FileManager().fileExists(atPath: filePath))")

      let myURL = URL(fileURLWithPath: filePath)
      let pdf = NSData(contentsOf: myURL)

      //print(pdf?.description ?? "No pdf values here")
      //print("---------------------------------------")
      let length = pdf?.length
      var myArray = [UInt8](repeating: 0, count: length!)
      pdf?.getBytes(&myArray, length: length!)

      //print(myArray.description)

      webView?.evaluateJavaScript("PDFViewerApplication.open(new Uint8Array(\(myArray)))", completionHandler: { result, error in
        print("Completed Javascript evaluation.")
        print("Result: \(String(describing: result))")
        print("Error: \(String(describing: error))")
      })
    }
    else {
      print("File \(urlString) doesn't exist")
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


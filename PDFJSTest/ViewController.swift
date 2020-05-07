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
        
        // first, load the PDF Viewer
        loadPDFViewer()
        
        // then, grab the PDF from the server and render in the viewer
//        renderServerPDF()
        
        // or grab the PDF locally in the bundle and render in the viewer
//            renderLocalPDF()
        
        let sv = UIBarButtonItem(title: "ServerPDF", style: .plain, target: self, action: #selector(self.renderServerPDF))
        let lc = UIBarButtonItem(title: "LocalPDF", style: .plain, target: self, action: #selector(self.renderLocalPDF))
        
        navigationItem.leftBarButtonItem = sv
        navigationItem.rightBarButtonItem = lc
    }
    
    func loadPDFViewer() {
        let urlString = "pdf.js-dist/web/viewer"
        
        let filePath = Bundle.main.resourceURL?.appendingPathComponent("\(urlString).html").path
        print("File \(urlString).html exists: \(FileManager().fileExists(atPath: filePath!))")
        
        // first, load the PDF viewer
        if let filePath = Bundle.main.url(forResource: urlString, withExtension: "html") {
            webView.load(URLRequest(url: filePath))
        }
    }
    
    func openPDFInViewer(myURL: URL) {
        guard let pdf = NSData(contentsOf: myURL) else { return}
        
        let length = pdf.length
        var myArray = [UInt8](repeating: 0, count: length)
        pdf.getBytes(&myArray, length: length)
                
        DispatchQueue.main.async {
            self.webView?.evaluateJavaScript("PDFViewerApplication.open(new Uint8Array(\(myArray)))", completionHandler: { result, error in
                print("Completed Javascript evaluation.")
                print("Result: \(String(describing: result))")
                print("Error: \(String(describing: error))")
            })
        }
    }
    
    @objc func renderServerPDF() {
        // Create URL to the source file you want to download
        guard let fileURL = URL(string: "http://www.africau.edu/images/default/sample.pdf") else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: fileURL)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                self.openPDFInViewer(myURL: tempLocalUrl)
                
            } else {
                print("Error took place while downloading a file.");
            }
        }
        
        task.resume()
    }
    
    @objc func renderLocalPDF() {
        
        // load the PDF into the viewer after a delay
        let timeDelay = 1.0 // in seconds
        Timer.scheduledTimer(timeInterval: timeDelay, target: self, selector: #selector(self.getLocalPDF), userInfo: nil, repeats: false)
    }
    
    @objc func getLocalPDF() {
        let urlString = "compressed.tracemonkey-pldi-09"
        //let urlString = "Linear Regression Using R- An Introduction to Data Modeling"
        //let urlString = "NumberTheoryAndAlgebra"
        //let urlString = "FinancialAccounting"
        
        if let filePath = Bundle.main.url(forResource: urlString, withExtension: "pdf") {
            print("File \(urlString).pdf exists: \(FileManager().fileExists(atPath: filePath.path))")
            
            openPDFInViewer(myURL: filePath)
        }
        else {
            print("File \(urlString) doesn't exist")
        }
    }
    
}


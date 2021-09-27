//
//  ViewController.swift
//  Simple Web Browser
//
//  Created by Alexander on 26.09.2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adressTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        adressTextField.text = homePage
       
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
    }
    @IBAction func forwardPressed(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let urlString = textField.text!
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
        
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        adressTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

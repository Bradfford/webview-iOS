//
//  GenericWebViewController.swift
//  webview-iOS
//
//  Created by Millfford Robert Lima Bradshaw on 12/12/22.
//

import UIKit
import WebKit

class GenericWebViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sendActionButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    var webView: WKWebView?

    override func loadView() {
        super.loadView()
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self, name: "callbackHandler")
        configuration.defaultWebpagePreferences = preferences
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView?.navigationDelegate = self
        self.containerView.addSubview(webView!)
        self.loadWebview()
        
    }
    
    private func loadWebview(){
        guard let url = URL(string: "http://127.0.0.1:4200/home") else {
            return
        }
        webView?.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView?.frame = containerView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DefaultNavBar.buildNavBar(controller: self, title: "WebView")
    }
    
    private func showAlert(_ text: String){
        let alert = UIAlertController(title: "Mensagem", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let params = "executeActionFromiOS();"
        webView?.evaluateJavaScript(params) { (any, error) in
            print("Error : \(String(describing: error))")
        }
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        self.reloadButton.isHidden.toggle()
        loadWebview()
    }
    
}

//MARK: Webview Delegates
extension GenericWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.showAlert(message.body as! String)
        print("Message received from webpage: \(message.body)")
    }
}

extension GenericWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Webpage is Loaded: \(String(describing: navigation))")
        
        self.sendActionButton.backgroundColor = UIColor(hexString: "01874D")
        self.sendActionButton.isEnabled = true
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.reloadButton.isHidden.toggle()
        print("Webpage is failed to Load: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.reloadButton.isHidden.toggle()
        print("Webpage is failed to Load: \(error)")
    }
    
}

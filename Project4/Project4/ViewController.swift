//
//  ViewController.swift
//  Project4
//
//  Created by Rustam Chergizbiev on 9/4/22.
//

import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var webSites = ["google.com", "hackingwithswift.com", "vt.ru"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let openSite = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let goBackButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(goBack))
        let goForwardButton = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(goForward))
        
        toolbarItems = [goBackButton, goForwardButton, spacer, progressButton, spacer, openSite, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://" + webSites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for webSite in webSites {
            ac.addAction(UIAlertAction(title: webSite, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //property is used only on iPad, and tells iOS where it should make the action sheet be anchored.
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for webSite in webSites {
                if host.contains(webSite) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        showAlert()
        decisionHandler(.cancel)
    }
    
    func showAlert() {
        let ac = UIAlertController(title: "Warning", message: "This site is blocked!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

}


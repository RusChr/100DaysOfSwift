//
//  DetailViewController.swift
//  Project7
//
//  Created by Rustam Chergizbiev on 9/10/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body style="text-align:justify;">
        <h1 style="background-color:powderblue;">\(detailItem.title)</h1>
        <hr>
        <p style="font-size:120%;">\(detailItem.body)</p>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}

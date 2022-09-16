//
//  BodyVC.swift
//  Project7
//
//  Created by Mymac on 16/9/2022.
//

import UIKit
import WebKit

class BodyVC: UIViewController {
    var webView : WKWebView!
    var detailItem : Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
        guard let detailItem = detailItem else {
            return
        }
        let html = """
                    <html>
                    <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <style> body { font-size: 150%; } </style>
                    </head>
                    <h3>\(detailItem.title)</h3>
                    <body>
                    \(detailItem.body)
                    </body>
                    </html>
                    """
        webView.loadHTMLString(html, baseURL: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

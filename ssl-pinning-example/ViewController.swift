//
//  ViewController.swift
//  ssl-pinning-example
//
//  Created by Dmitry Fink on 4/5/17.
//  Copyright © 2017 Dmitry Fink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        if let url = NSURL(string: "https://www.google.com/") {

            let session = URLSession(
                configuration: URLSessionConfiguration.ephemeral,
                delegate: URLSessionPinningDelegate(),
                delegateQueue: nil)

            let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print("error: \(error!.localizedDescription))")
                } else if data != nil {
                    if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                        print("Received data:\n\(str)")
                    }
                    else {
                        print("Unable to convert data to text")
                    }
                }
            })
            
            task.resume()
        }
        else {
            print("Unable to create NSURL")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


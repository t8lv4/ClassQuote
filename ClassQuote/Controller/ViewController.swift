//
//  ViewController.swift
//  ClassQuote
//
//  Created by Morgan on 06/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    @IBAction func tappedNewQuoteButton(_ sender: Any) {
        QuoteService.getQuote()
    }
}


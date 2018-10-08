//
//  FakeResponseData.swift
//  QuoteServiceTests
//
//  Created by Morgan on 08/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

class FakeResponseData {
    //create responses
    let reponseOK = HTTPURLResponse(url: URL(string: "https://t8lv4.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let reponseKO = HTTPURLResponse(url: URL(string: "https://t8lv4.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!


    //get forismatic data from Quote.json
    var quoteCorrectData: Data {
        //get Quote.json bundle
        let bundle = Bundle(for: FakeResponseData.self)
        //get path to Quote.json
        let url = bundle.url(forResource: "Quote", withExtension: "json")
        //get contents of Quote.json
        let data = try! Data(contentsOf: url!)

        return data
    }

    //create incorrect data format by encoding a string
    let quoteIncorrectData = "error".data(using: .utf8)!
    let imageData = "image".data(using: .utf8)!

    //to simulate if there's an error or not
    class QuoteError: Error {}
    let error = QuoteError()

}

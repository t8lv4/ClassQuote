//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Morgan on 06/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

class QuoteService {
    //singleton pattern
    static var shared = QuoteService()
    private init() {}

    private static let quoteURL = URL(string: "https://api.forismatic.com/api/1.0/")!
    private static let pictureURL = URL(string: "https://source.unsplash.com/random/1000x1000")!
    private var task: URLSessionDataTask?

    func getQuote(callback: @escaping (Bool, Quote?) -> Void) {
        //create request
        let request = QuoteService.createQuoteRequest()
        //create session call
        let session = URLSession(configuration: .default)

        task?.cancel()
        //create task for the session
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                //handle response
                //check error
                if let data = data, error == nil {
                    //check response
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        //decode response
                        if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                            let text = responseJSON["quoteText"], let author = responseJSON["quoteAuthor"] {
                            self.getImage { (data) in
                                if let data = data {
                                    let quote = Quote(text: text, author: author, imageData: data)
                                    callback(true, quote)
                                } else {
                                    callback(false, nil)
                                }
                            }
                        } else {
                            callback(false, nil)
                        }
                    } else {
                        callback(false, nil)
                    }
                } else {
                    callback(false, nil)
                }
            }
        }
        //launch task
        task?.resume()
    }

    private static func createQuoteRequest() -> URLRequest {
        //create request
        var request = URLRequest(url: quoteURL)
        //attach http method
        request.httpMethod = "POST"

        //create body
        let body = "method=getQuote&format=json&lang=en"
        //attach body to request and specifie format of the datas to be sent
        request.httpBody = body.data(using: .utf8)

        return request
    }

    private func getImage(completionHandler: @escaping ((Data?) -> Void)) {
        let session = URLSession(configuration: .default)
        task?.cancel()
        
        task = session.dataTask(with: QuoteService.pictureURL) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        completionHandler(data)
                    } else {
                        completionHandler(nil)
                    }
                } else {
                    completionHandler(nil)
                }
            }
        }
        task?.resume()
    }
}

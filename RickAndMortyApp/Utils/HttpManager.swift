//
//  ImageView.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 15.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class HttpManager {
    
    private var count = 0
    
    public var dictonary: [String: Wrapper] = [:] {
        didSet {
            if dictonary.count == self.count {
                self.done()
            }
        }
    }
    
    private var completions: [() -> Void]? = []
    
    private func done(){
        for completion in completions ?? [] {
            completion()
        }
        completions = nil
    }
    
    public func addClosure(_ closure: @escaping () -> Void) -> HttpManager {
        self.completions?.append {
            closure()
        }
        return self
    }
    
    public func sendRequest(url urlString: String, key: String) -> HttpManager {
        self.count += 1
        
        guard let url = URL.init(string: urlString) else { return self }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url){ (data, response, error) in
            self.dictonary[key] = Wrapper(response: response!, key: key, data: data!)
        }
        
        task.resume()
        
        return self
    }
    
    struct Wrapper {
        let response: URLResponse
        let key: String
        let data: Data
    }
}

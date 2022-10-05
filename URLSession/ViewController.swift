//
//  ViewController.swift
//  URLSession
//
//  Created by Дмитрий on 16.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    private func makeRequest() {
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/Any?safe-mode") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                print(joke.setup)
                DispatchQueue.main.async {
                    self.jokeLabel.text = joke.setup
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

}


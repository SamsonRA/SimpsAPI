//
//  CharacterPresenter.swift
//  SimpsAPI
//
//  Created by . on 27.09.2023.
//

import Foundation

class CharacterPresenter {
    
    let url = "https://thesimpsonsquoteapi.glitch.me/quotes"
    
    func fetchData(completion: @escaping (Character) ->Void ) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            
            guard let data = data else { return }
            
            
            do {
                let result = try JSONDecoder().decode([Character].self, from: data)
                
                guard let image = result.first?.image,
                      let urlImage = URL(string: image),
                      let characterImageData = try? Data(contentsOf: urlImage) else { return }
                
                DispatchQueue.main.async {
                    completion(result.first!)
//                    self.quote.text = result.first?.quote
//                    self.characterName.text = result.first?.character
//                    self.characterImageView.image = UIImage(data: characterImageData)
//                    self.imageActivityIndicatorView.stopAnimating()
                }
            } catch let error {
                print("Error: \(error)")
            }
        }.resume()
    }
}

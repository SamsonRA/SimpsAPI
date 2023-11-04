//
//  CharacterPresenter.swift
//  SimpsAPI
//
//  Created by . on 27.09.2023.
//
//
import Foundation
//import UIKit
import Alamofire
let url = "https://thesimpsonsquoteapi.glitch.me/quotes"
//
class CharacterPresenter {
    weak var view: CharacterViewController?
    
    
    func sendRequest(url: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        
        AF.request(url).validate().responseDecodable(of: [Character].self, queue: .main,  decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}
   



    



    






//
//    func fetchData(completion: @escaping (Character, UIImage) ->Void ) {
//        guard let url = URL(string: url) else { return }
//
//
//        URLSession.shared.dataTask(with: url) { (data, respons, error) in
//
//            guard let data = data else { return }
//
//
//            do {
//                let result = try JSONDecoder().decode([Character].self, from: data)
//
//                guard let image = result.first?.image,
//                      let urlImage = URL(string: image),
//                      let characterImageData = try? Data(contentsOf: urlImage) else { return }
//
//                DispatchQueue.main.async {
//                    completion(result.first!, UIImage(data: characterImageData)!)
//                    //                    self.quote.text = result.first?.quote
//                    //                    self.characterName.text = result.first?.character
//                    //                    self.characterImageView.image = UIImage(data: characterImageData)
//                    //                    self.imageActivityIndicatorView.stopAnimating()
//                }
//            } catch let error {
//                print("Error: \(error)")
//            }
//        }.resume()
//    }
//    
//    
//}

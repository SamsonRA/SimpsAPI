//
//  NetworkService.swift
//  SimpsAPI
//
//  Created by . on 09.10.2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    let url = "https://thesimpsonsquoteapi.glitch.me/quotes"
    
    func sendRequest(url: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().responseDecodable(of: [Character].self, queue: .main,  decoder: JSONDecoder()) { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func requestImage(url: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            guard let characterImageData = try? Data(contentsOf: url) else { return}
            guard let image = UIImage(data: characterImageData) else { return }
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    
    
}


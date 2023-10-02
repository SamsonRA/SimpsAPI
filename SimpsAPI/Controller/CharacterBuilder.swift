//
//  CharacterBuilder.swift
//  SimpsAPI
//
//  Created by . on 02.10.2023.
//

import Foundation
import UIKit

final class CharacterBuilder {
    
    func build() -> UIViewController {
       let presenter = CharacterPresenter()
        let vc = CharacterViewController(presenter: presenter)
        
        return UIViewController()
    }
    
}

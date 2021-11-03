//
//  MUStringExtension.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation
import CryptoKit

extension String {
   
    func md5() -> String {
        
        guard let d = self.data(using: .utf8) else { return ""}
        let digest = Insecure.MD5.hash(data: d)
        let string = digest.reduce("") { (res: String, element) in
            let hex = String(format: "%02x", element)
            let  t = res + hex
            return t
        }
        return string
    }
}

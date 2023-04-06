//
//  File.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.

//

import Foundation
// MARK: - string
extension String
{
    // Handling Localization ....
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
    
    func dateBackendFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: MOLHLanguage.isArabic() ? "ar" : "en")
        let date = dateFormatter.date(from: self)
        dateFormatter.locale = Locale(identifier: "en")
        print(dateFormatter.string(from: date ?? Date()))
        return dateFormatter.string(from: date ?? Date())
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: Constants.shared.isAR ? "ar" : "en")
        
        if let formattedDate = dateFormatter.date(from: self) {
            return dateFormatter.string(from: formattedDate)
        } else {
            return self
        }
    }
    //Html String Attrributed
    var htmlToAttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}



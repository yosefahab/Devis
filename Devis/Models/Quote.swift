//
//  Quote.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

import Foundation
import SwiftUI

struct Quote : Identifiable , Codable {
    let id: UUID
    var type: String
    var text: String
    var author: String
    var isFavourite: Bool
    var quoteStyle: QuoteStyle
    
    init(id: UUID = UUID(), type: String, quote: String, author: String, isFavourite: Bool = false, quoteStyle: QuoteStyle = QuoteStyle()){
        self.id = id
        self.type = type
        self.text = quote
        self.author = author
        self.isFavourite = isFavourite
        self.quoteStyle = quoteStyle
    }
    init(){
        self.init(type: Constants.types.Motivational.rawValue, quote: "", author: "")
    }
}

extension Quote {
    struct QuoteStyle : Codable {
        var theme: Theme
        var isGradient: Bool
        var image: Data?
        var whiteFont: Bool
        var colorOpacity: Float
        var imageOpacity: Float
        
        init(){
            self.theme = .teal
            self.isGradient = true
            self.whiteFont = true
            self.colorOpacity = 1.0
            self.imageOpacity = 1.0
            setImage(image: nil)
        }
        
        init(theme: Theme, isGradient: Bool,
             whiteFont: Bool = true, image: UIImage? = nil, colorOpacity: Float = 1.0, imageOpacity: Float = 1.0) {
            self.theme = theme
            self.isGradient = isGradient
            self.whiteFont = whiteFont
            self.colorOpacity = colorOpacity
            self.imageOpacity = imageOpacity
            setImage(image: image)
        }
        
        mutating func setImage(image : UIImage?) {
            if image != nil {
                self.image = image!.pngData()!
            }
            else{
                self.image = nil
            }
        }
    }
    struct QuoteData {
        var type: String = Constants.types.Motivational.rawValue
        var text: String = ""
        var author: String = ""
        var isFavourite: Bool = false
        var quoteStyle: QuoteStyle = QuoteStyle()
    }
    var data: QuoteData {
        QuoteData(type: type, text: text, author: author, isFavourite: isFavourite, quoteStyle: quoteStyle)
    }
    
    mutating func update(from data: QuoteData, image: UIImage?) {
        self.type = data.type
        self.text = data.text
        self.author = data.author
        self.isFavourite = data.isFavourite
        self.quoteStyle = data.quoteStyle
        self.quoteStyle.setImage(image: image)
    }
    
    init(data: QuoteData) {
        self.id = UUID()
        self.type = data.type
        self.text = data.text
        self.author = data.author
        self.isFavourite = data.isFavourite
        self.quoteStyle = data.quoteStyle
    }
}

extension Image {
    public init?(data: Data?) {
        guard let data = data,
            let uiImage = UIImage(data: data) else {
                return nil
        }
        self = Image(uiImage: uiImage)
    }
}

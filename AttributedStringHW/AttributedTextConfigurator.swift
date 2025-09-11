//
//  AttributedTextConfigurator.swift
//  AttributedStringHW
//
//  Created by Артём Сноегин on 11.09.2025.
//

import UIKit

class AttributedTextConfigurator {
    
    func configureAttributedText(for product: Product) -> NSMutableAttributedString {
        let fontSize: CGFloat = 20
        
        let centeredStyle = NSMutableParagraphStyle()
        centeredStyle.lineSpacing = 8
        centeredStyle.alignment = .center
        
        let justifiedStyle = NSMutableParagraphStyle()
        justifiedStyle.paragraphSpacingBefore = 12
        justifiedStyle.paragraphSpacing = 12
        justifiedStyle.alignment = .justified
        
        let paragraphs = product.description.components(separatedBy: "\n")
        let firstParagraph = paragraphs[1]
        
        let attributedText = NSMutableAttributedString(string: product.description, attributes: [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .light),
            .paragraphStyle: centeredStyle,
            .foregroundColor: UIColor.secondaryLabel
        ])
        
        let nsString = NSString(string: product.description)

        attributedText.addAttribute(.paragraphStyle, value: justifiedStyle, range: nsString.range(of: firstParagraph))
        attributedText.addAttribute(.foregroundColor, value: UIColor.label, range: nsString.range(of: firstParagraph))
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: nsString.range(of: firstParagraph))
        
        if let customFont = UIFont(name: "TimelessMemories-Regular", size: fontSize) {
            let sentences = product.description.components(separatedBy: ".")
            let firstSentence = sentences[0]
            attributedText.addAttribute(.font, value: customFont, range: nsString.range(of: firstSentence))
        }
        
        for key in product.keyWords {
            attributedText.addAttribute(.foregroundColor, value: product.keyWordColor, range: nsString.range(of: key))
        }

        if let url = URL(string: product.urlString) {
            let linkAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont.systemFont(ofSize: fontSize),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .link: url
            ]
            
            attributedText.addAttributes(linkAttributes, range: nsString.range(of: "Pre-order"))
        }
        
        if let image = UIImage(named: product.imageString) {
            let imageAttachment = NSTextAttachment(image: image)
            let imageString = NSMutableAttributedString(attachment: imageAttachment)
            imageString.addAttribute(.paragraphStyle, value: centeredStyle, range: NSRange(location: 0, length: imageString.length))
            
            attributedText.insert(imageString, at: 0)
        }
        
        return attributedText
    }
}

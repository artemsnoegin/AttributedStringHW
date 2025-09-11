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

        let attributedText = NSMutableAttributedString()

        if let image = UIImage(named: product.imageString) {
            let attachment = NSTextAttachment(image: image)
            let imageString = NSMutableAttributedString(attachment: attachment)
            imageString.addAttribute(.paragraphStyle, value: centeredStyle, range: NSRange(location: 0, length: imageString.length))
            imageString.append(NSAttributedString(string: "\n"))
            attributedText.append(imageString)
        }

        let text = NSMutableAttributedString(string: product.description, attributes: [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .light),
            .paragraphStyle: centeredStyle,
            .foregroundColor: UIColor.secondaryLabel
        ])
        
        let paragraphs = product.description.components(separatedBy: "\n")
        let firstParagraph = paragraphs[0]

        let nsString = text.string as NSString
        
        text.addAttribute(.paragraphStyle, value: justifiedStyle, range: nsString.range(of: firstParagraph))
        text.addAttribute(.foregroundColor, value: UIColor.label, range: nsString.range(of: firstParagraph))
        text.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: nsString.range(of: firstParagraph))

        if let customFont = UIFont(name: "TimelessMemories-Regular", size: fontSize) {
            let sentences = product.description.components(separatedBy: ".")
            let firstSentence = sentences[0]
            text.addAttribute(.font, value: customFont, range: nsString.range(of: firstSentence))
        }

        for key in product.keyWords {
            let range = nsString.range(of: key)
            if range.location != NSNotFound {
                text.addAttribute(.foregroundColor, value: product.keyWordColor, range: range)
            }
        }

        if let url = URL(string: product.urlString) {
            let linkRange = nsString.range(of: "Pre-order")
            if linkRange.location != NSNotFound {
                text.addAttributes([
                    .link: url,
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .font: UIFont.systemFont(ofSize: fontSize)
                ], range: linkRange)
            }
        }

        attributedText.append(text)
        
        return attributedText
    }
}

//
//  ViewController.swift
//  AttributedStringHW
//
//  Created by Артём Сноегин on 10.09.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let data = DataStore()
    
    private let control = UISegmentedControl()
    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let textLabel = UILabel()
        textLabel.text = "Product"
        textLabel.textAlignment = .center
        textLabel.font = .preferredFont(forTextStyle: .headline)
        
        control.insertSegment(withTitle: "Pro", at: 0, animated: true)
        control.insertSegment(withTitle: "Air", at: 1, animated: true)
        control.insertSegment(withTitle: "Watch", at: 2, animated: true)
        control.addTarget(self, action: #selector(switchControl(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 0
        switchControl(control)
        
        textView.backgroundColor = .systemBackground
        textView.isEditable = false
        
        [textLabel, control, textView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            control.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func switchControl(_ control: UISegmentedControl) {
        let index = control.selectedSegmentIndex
        
        let product = data.products[index]
        let attributedText = configureAttributedText(for: product)
        
        UIView.transition(with: view, duration: 0.4, options: [.transitionCrossDissolve], animations: {
            switch index {
            case 0:
                self.overrideUserInterfaceStyle = .dark
            case 1:
                self.overrideUserInterfaceStyle = .light
            case 2:
                self.overrideUserInterfaceStyle = .light
            default:
                break
            }

            self.textView.attributedText = attributedText
        })
    }
    
    private func configureAttributedText(for product: Product) -> NSMutableAttributedString {
        let fontSize: CGFloat = 20
        
        let centeredStyle = NSMutableParagraphStyle()
        centeredStyle.lineSpacing = 8
        centeredStyle.alignment = .center
        
        let justifiedStyle = NSMutableParagraphStyle()
        justifiedStyle.paragraphSpacingBefore = 12
        justifiedStyle.paragraphSpacing = 12
        justifiedStyle.alignment = .justified
        
        let paragraphs = product.text.components(separatedBy: "\n")
        let firstParagraph = paragraphs[1]
        
        let attributedText = NSMutableAttributedString(string: product.text, attributes: [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .light),
            .paragraphStyle: centeredStyle,
            .foregroundColor: UIColor.secondaryLabel
        ])
        
        let nsString = NSString(string: product.text)

        attributedText.addAttribute(.paragraphStyle, value: justifiedStyle, range: nsString.range(of: firstParagraph))
        attributedText.addAttribute(.foregroundColor, value: UIColor.label, range: nsString.range(of: firstParagraph))
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: nsString.range(of: firstParagraph))
        
        if let customFont = UIFont(name: "TimelessMemories-Regular", size: fontSize) {
            let sentences = product.text.components(separatedBy: ".")
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

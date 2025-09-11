//
//  ViewController.swift
//  AttributedStringHW
//
//  Created by Артём Сноегин on 10.09.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let data = DataStore()
    private let configurator = AttributedTextConfigurator()
    
    private let control = UISegmentedControl()
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = "Product"
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        
        data.products.forEach {
            control.insertSegment(withTitle: $0.name, at: 0, animated: true)
        }
        
        control.addTarget(self, action: #selector(switchControl(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 0
        switchControl(control)
        
        textView.backgroundColor = .systemBackground
        textView.isEditable = false
        
        [titleLabel, control, textView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            control.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
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
        let attributedText = configurator.configureAttributedText(for: product)
        
        UIView.transition(with: view, duration: 0.4, options: [.transitionCrossDissolve], animations: {
            self.overrideUserInterfaceStyle = product.preferredUserInterfaceStyle
            self.textView.attributedText = attributedText
        })
    }

}

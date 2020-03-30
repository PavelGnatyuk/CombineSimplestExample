//
//  ViewController.swift
//  CombineSimplestExample
//
//  Created by Pavel Gnatyuk on 29/03/2020.
//  Copyright © 2020 Pavel Gnatyuk. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private lazy var textFieldName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()
    
    private lazy var textFieldLayout: [NSLayoutConstraint] = {
        [textFieldName.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
         textFieldName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
         textFieldName.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
    }()

    private lazy var buttonDone: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapOnDone(_:)))
        button.isEnabled = false
        return button
    }()

    @Published private var isDoneEnabled: Bool = false
    private var enabling: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = buttonDone
        view.addSubview(textFieldName)
        NSLayoutConstraint.activate(textFieldLayout)
        enabling = $isDoneEnabled.receive(on: DispatchQueue.main).assign(to: \.isEnabled, on: buttonDone)
        textFieldName.becomeFirstResponder()
    }

}

extension ViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isDoneEnabled = (!string.isEmpty || range.length < (textField.text ?? "").count)
        return true
    }
}

extension ViewController {
    @objc func tapOnDone(_ sender: AnyObject?) {
        debugPrint("File: \(#file) \(#function)")
    }
}

